--***********************************************************
--**                       Lanttuchef                       **
--***********************************************************

local function getTableLength(table)
    local count = 0
    for _ in pairs(table) do count = count + 1 end
    return count
end

local function onInitGlobalModData()
	if not isClient() then return end

	if ModData.exists("HordeEventTrigger.eventTriggerList") then
		ModData.remove("HordeEventTrigger.eventTriggerList")
	end

	HordeEventTrigger.eventTriggerList = ModData.getOrCreate("HordeEventTrigger.eventTriggerList")
	ModData.request("HordeEventTrigger.eventTriggerList")
end

local function onReceiveGlobalModData(modDataName, data)
    if modDataName ~= "HordeEventTrigger.eventTriggerList" then return end
    if not HordeEventTrigger.eventTriggerList then return end

    for key, value in pairs(data) do
        HordeEventTrigger.eventTriggerList[key] = value
    end
end

local function onServerCommand(module, command, arguments)
    if module ~= "HordeEventTrigger" then return end
    if command ~= "UpdateEventTriggers" then return end
    if not isClient() then return end

    if ModData.exists("HordeEventTrigger.eventTriggerList") then
        ModData.remove("HordeEventTrigger.eventTriggerList")
    end

    HordeEventTrigger.eventTriggerList = ModData.getOrCreate("HordeEventTrigger.eventTriggerList")
    ModData.request("HordeEventTrigger.eventTriggerList")
end

Events.OnServerCommand.Add(onServerCommand)
Events.OnInitGlobalModData.Add(onInitGlobalModData)
Events.OnReceiveGlobalModData.Add(onReceiveGlobalModData)