--**************************************************************************************
--**									 Lanttuchef									  **
--**  Considerable portion of code derived from Horde Event Mod, by BitRaven **
--**************************************************************************************

require "ISUI/ISPanelJoypad"
LC_HET_ISHordeEventTriggerUI = ISCollapsableWindow:derive("ISHordeEventTriggerUI");

function LC_HET_ISHordeEventTriggerUI:createChildren()
	local btnWid = 100
	local btnHgt = 25
	local padBottom = 0
	local y = 60
	local f = 0.8

	ISCollapsableWindow.createChildren(self)

	self.hordeEventIdLabel = ISLabel:new(10, y, 10, getText("IGUI_Horde_Event_Id") , 1, 1, 1, 1, UIFont.Small, true)
	self:addChild(self.hordeEventIdLabel)

	self.triggerStartTimeLbl = ISLabel:new(130, y, 10, getText("IGUI_Trigger_Time") , 1, 1, 1, 1, UIFont.Small, true)
	self:addChild(self.triggerStartTimeLbl)
  
	y=y+15

	self.hordeEventId = ISTextEntryBox:new("1", self.hordeEventIdLabel.x, y, 100, 20)
	self.hordeEventId:initialise()
	self.hordeEventId:instantiate()
	self.hordeEventId:setOnlyNumbers(true)
	self:addChild(self.hordeEventId)

	self.triggerStartTime = ISTextEntryBox:new("1", self.triggerStartTimeLbl.x, y, 100, 20)
	self.triggerStartTime:initialise()
	self.triggerStartTime:instantiate()
	self.triggerStartTime:setOnlyNumbers(true)
	self:addChild(self.triggerStartTime)

	self.add = ISButton:new(10, self:getHeight() - padBottom - btnHgt - 22, btnWid*f, btnHgt, getText("IGUI_Add"), self, LC_HET_ISHordeEventTriggerUI.onAdd)
	self.add.anchorTop = false
	self.add.anchorBottom = true
	self.add:initialise()
	self.add:instantiate()
	self.add.borderColor = {r=1, g=1, b=1, a=0.1}
	self:addChild(self.add)

	self.closeButton2 = ISButton:new(self.width - btnWid*f - 10, self.add.y, btnWid*f, btnHgt, getText("UI_Close"), self, LC_HET_ISHordeEventTriggerUI.close)
	self.closeButton2.anchorTop = false
	self.closeButton2.anchorBottom = true
	self.closeButton2:initialise()
	self.closeButton2:instantiate()
	self.closeButton2.borderColor = {r=1, g=1, b=1, a=0.1}
	self:addChild(self.closeButton2)
end

function LC_HET_ISHordeEventTriggerUI:getTriggerStartTime()
	local triggerStartTime = self.triggerStartTime:getInternalText()
	return (tonumber(triggerStartTime) or 1)
end

function LC_HET_ISHordeEventTriggerUI:onAdd()
	local id = self:getHordeEventId()
	local startTime = self:getTriggerStartTime()

	local args = {eventId = id, startTime = startTime}
	sendClientCommand(getPlayer(), "HordeEventTrigger", "AddEventTrigger", args)
end

function LC_HET_ISHordeEventTriggerUI:getHordeEventId()
	local id = self.hordeEventId:getInternalText()
	return tonumber(id) or 1
end

function LC_HET_ISHordeEventTriggerUI:prerender()
	ISCollapsableWindow.prerender(self)
end

function LC_HET_ISHordeEventTriggerUI:render()
	ISCollapsableWindow.render(self)
end

function LC_HET_ISHordeEventTriggerUI:close()
	self:setVisible(false)
	self:removeFromUIManager()
end

function LC_HET_ISHordeEventTriggerUI:new(x, y, character, square)
	local width = 250
	local height = 200
	local o = ISCollapsableWindow.new(self, x, y, width, height)
	o.playerNum = character:getPlayerNum()
	if y == 0 then
		o.y = getPlayerScreenTop(o.playerNum) + (getPlayerScreenHeight(o.playerNum) - height) / 2
		o:setY(o.y)
	end
	if x == 0 then
		o.x = getPlayerScreenLeft(o.playerNum) + (getPlayerScreenWidth(o.playerNum) - width) / 2
		o:setX(o.x)
	end
	o.width = width
	o.height = height
	o.chr = character
	o.moveWithMouse = true
	o.selectX = square:getX()
	o.selectY = square:getY()
	o.selectZ = square:getZ()
	o.anchorLeft = true
	o.anchorRight = true
	o.anchorTop = true
	o.anchorBottom = true
	return o
end
