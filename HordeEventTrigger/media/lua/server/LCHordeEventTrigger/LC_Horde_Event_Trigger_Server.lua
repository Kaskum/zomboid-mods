--***********************************************************
--**                       Lanttuchef                      **
--***********************************************************

HordeEventTrigger = {}
HordeEventTrigger.eventTriggerList = {}

local activeTriggers = 0
local uniqueIndex = 1
local freeIndexes = {}

local function getTableLength(table)
    local count = 0
    for _ in pairs(table) do count = count + 1 end
    return count
end

local function getFreeIndex()
  local newFreeIndex = 0
  if #freeIndexes == 0 then
    newFreeIndex = uniqueIndex
    uniqueIndex = uniqueIndex + 1
  else
    newFreeIndex = freeIndexes[1]
    table.remove(freeIndexes, 1)
  end
  print("Reserving index: ", newFreeIndex)
  return newFreeIndex
end

local function addFreeIndex(newFreeIndex)
  print("Freeing index: ", newFreeIndex)
  table.insert(freeIndexes, newFreeIndex)
end

-- Credits for this function: Konijima
local delayFunction = function(func, delay)

  delay = delay or 1
  local ticks = 0
  local canceled = false

  local function onTick()
      if not canceled and ticks < delay then
          ticks = ticks + 1
          return
      end

      Events.OnTick.Remove(onTick)
      if not canceled then func() end
  end

  Events.OnTick.Add(onTick)
  return function()
      canceled = true
  end
end

local function findHordeEvent(triggerIndex)
  if not HordeEvents.eventList then return end
  for i,event in pairs(HordeEvents.eventList) do
    if event.triggerIndex == triggerIndex then
      return i
    end
  end

  return nil
end

local triggerEvent = function(triggerIndex)
  if not HordeEvents.eventList then return end
  if getTableLength(HordeEvents.eventList) <= 0 then return end

  print(string.format("Triggering Horde Event Id: %d", triggerIndex))

  local hordeEventIndex = findHordeEvent(triggerIndex)
  if not hordeEventIndex then return end

  local hordeEvent = HordeEvents.eventList[hordeEventIndex]

  local count = hordeEvent.zNumber
  local radius = hordeEvent.radius
  local delay = hordeEvent.delay
  local zOutfit = hordeEvent.zOutfit
  local femChance = hordeEvent.femChance
  local isKnockedDown = hordeEvent.isKnockedDown
  local isCrawler = hordeEvent.isCrawler
  local isFakeDead = hordeEvent.isFakeDead
  local isFallOnFront = hordeEvent.isFallOnFront
  local zHealth = hordeEvent.zHealth
  local squareX = hordeEvent.centralSquare.x
  local squareY = hordeEvent.centralSquare.y
  local squareZ = hordeEvent.centralSquare.z
  local args = { index = hordeEventIndex }
  sendClientCommand(getPlayer(), "HordeEvent", "TriggerEvent", args)
  
  delayFunction(function()
    sendClientCommand(getPlayer(), "HordeEvent", "SpawnHorde", hordeEvent)
  end, delay * 60)
end

HordeEventTrigger.UpdateClients = function ()
    print("Horde Event Trigger is now updating clients...")

    if getWorld():getGameMode() == "Multiplayer" then
        local onlinePlayers = getOnlinePlayers()

        for i = 1, onlinePlayers:size() do
            local player = onlinePlayers:get(i - 1)

            if player then
                sendServerCommand(player, "HordeEventTrigger", "UpdateEventTriggers", {})
            end
        end
    else
        local player = getPlayer()
        if player then
            sendServerCommand(player, "HordeEventTrigger", "UpdateEventTriggers", {})
        end
    end
end

HordeEventTrigger.AddEvent = function(eventValues)
    if not HordeEventTrigger.eventTriggerList then return end
    if not HordeEvents.eventList then return end

    local hordeEvent = HordeEvents.eventList[eventValues.eventId]
    if not hordeEvent then
      print("Could not add trigger for non existing horde event: ", eventValues.eventId)
      return
    end

    eventValues.index = getFreeIndex()

    -- Add additional trigger index
    hordeEvent.triggerIndex = eventValues.index

    print(string.format("Adding event to index: %d. Horde Event Id: %d, Time: %d", eventValues.index, eventValues.eventId, eventValues.startTime))
    HordeEventTrigger.eventTriggerList[eventValues.index] = eventValues

    activeTriggers = activeTriggers + 1
    HordeEventTrigger.UpdateClients()
end

HordeEventTrigger.DeleteEvent = function(i)
    if not HordeEventTrigger.eventTriggerList then return end

    if i ~= -1 then
        HordeEventTrigger.eventTriggerList[i] = nil
        table.remove(HordeEventTrigger.eventTriggerList, i)
        addFreeIndex(i)
        activeTriggers = activeTriggers - 1
    else
        for k,v in pairs(HordeEventTrigger.eventTriggerList) do
            HordeEventTrigger.eventTriggerList[k] = nil
            addFreeIndex(k)
            activeTriggers = activeTriggers - 1
        end
    end

    HordeEventTrigger.UpdateClients()
end

local function onInitGlobalModData()
    HordeEventTrigger.eventTriggerList = ModData.getOrCreate("HordeEventTrigger.eventTriggerList")
end

local function onClientCommand(module, command, playerObj, args)
    if module ~= "HordeEventTrigger" then return end

    if command == "AddEventTrigger" then
        HordeEventTrigger.AddEvent(args)
    elseif command == "DeleteEventTrigger" then
        HordeEventTrigger.DeleteEvent(args.index)
    end
end

local function everyMinute()
end

local tickCounter = 0

local function onTick()
  if activeTriggers == 0 then return end

  tickCounter = tickCounter + 1
  if tickCounter == 60 then
    tickCounter = 0
    for k,event in pairs(HordeEventTrigger.eventTriggerList) do
      if event then
        if event.startTime > 0 then
          event.startTime = event.startTime - 1
        end
        if event.startTime == 0 then
          print(string.format("Triggering index: %d", event.index))
          triggerEvent(event.index)
          HordeEventTrigger.DeleteEvent(event.index)
        end
      end
    end
  end
end

Events.EveryOneMinute.Add(everyMinute)
Events.OnTick.Add(onTick)
Events.OnClientCommand.Add(onClientCommand)
Events.OnInitGlobalModData.Add(onInitGlobalModData)