--***********************************************************
--**                       Lanttuchef                       **
--***********************************************************

local onHordeEventTriggerWindow = function(square, playerObj)
  local ui = LC_HET_ISHordeEventTriggerUI:new(0, 0, playerObj, square)
  ui:initialise()
  ui:addToUIManager()
end

local onDeleteEventTrigger = function(eventTriggerIndex, playerObj)
  local args = {index = eventTriggerIndex}
  sendClientCommand(playerObj, "HordeEventTrigger", "DeleteEventTrigger", args)
end

local onWorldContextMenu = function(player, context, worldobjects, test)
  if not (isClient() and isAdmin() or getWorld():getGameMode() ~= "Multiplayer") then return true end
  if test and ISWorldObjectContextMenu.Test then return true end
  local playerObj = getSpecificPlayer(player)
  local square = nil

  for i,v in ipairs(worldobjects) do
      square = v:getSquare()
      break
  end

  local hordeEventTriggerOption = context:addOption(getText("ContextMenu_Horde_Event_Trigger"), worldobjects, nil)
  local subMenu = ISContextMenu:getNew(context)
  context:addSubMenu(hordeEventTriggerOption, subMenu)
  subMenu:addOption(getText("ContextMenu_Horde_New_Event_Trigger"), square, onHordeEventTriggerWindow, playerObj)

  local deleteEventTriggerOption = subMenu:addOption(getText("ContextMenu_Horde_Delete_Event_Trigger"), nil, nil)
  local delEventTriggerSubmenu = ISContextMenu:getNew(subMenu)
  subMenu:addSubMenu(deleteEventTriggerOption, delEventTriggerSubmenu)
  delEventTriggerSubmenu:addOption(getText("ContextMenu_Horde_Delete_All_Event_Triggers"), -1, onDeleteEventTrigger, playerObj)

  if not HordeEventTrigger.eventTriggerList then return end
  for i,event in ipairs(HordeEventTrigger.eventTriggerList) do
    delEventTriggerSubmenu:addOptionOnTop("Event Trigger "..event.index, event.index, onDeleteEventTrigger, playerObj)
  end

  context:addSubMenu(subMenu, delEventTriggerSubmenu)
end

Events.OnFillWorldObjectContextMenu.Add(onWorldContextMenu)