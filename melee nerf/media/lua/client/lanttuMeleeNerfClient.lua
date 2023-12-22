LanttuMeleeNerf = {}

LanttuMeleeNerf.MoveDirection = {
	STANDING = 0,
	SIDEWAYS = 1,
	FORWARD = 2,
	BACKWARD = 3
}

LanttuMeleeNerf.walkDirection = function (character)
	if not character:isPlayerMoving() then return LanttuMeleeNerf.MoveDirection.STANDING end

	local move_direction = character:getPlayerMoveDir():getDirection()
	local look_angle = character:getDirectionAngle()
	
	if move_direction > 0.78 and move_direction < 0.79 then
		--print("WALKING [N]")
		if look_angle <= -45 and look_angle >= -135 then
			--print("WALKING [N] FORWARD")
			return LanttuMeleeNerf.MoveDirection.FORWARD
		elseif look_angle >= 45 and look_angle <= 135 then
			--print("WALKING [N] BACKWARD")
			return LanttuMeleeNerf.MoveDirection.BACKWARD
		end 
	elseif move_direction == 0 then
		--print("WALKING [NE]")
		if look_angle >= -90 and look_angle <= -0 then
			--print("WALKING [NE] FORWARD")
			return LanttuMeleeNerf.MoveDirection.FORWARD
		elseif look_angle <= 180 and look_angle >= 90 then
			--print("WALKING [NE] BACKWARD")
			return LanttuMeleeNerf.MoveDirection.BACKWARD
		end 
	elseif move_direction < -0.78 and move_direction > -0.79 then
		--print("WALKING [E]")
		if look_angle >= -45 and look_angle <= 45 then
			--print("WALKING [E] FORWARD")
			return LanttuMeleeNerf.MoveDirection.FORWARD
		elseif (look_angle >= 135 and look_angle <= 180) or (look_angle <= -135 and look_angle >= -180) then
			--print("WALKING [E] BACKWARD")
			return LanttuMeleeNerf.MoveDirection.BACKWARD
		end 
	elseif move_direction < -1.57 and move_direction > -1.58 then
		--print("WALKING [SE]")
		if look_angle >= 0 and look_angle <= 90 then
			--print("WALKING [SE] FORWARD")
			return LanttuMeleeNerf.MoveDirection.FORWARD
		elseif look_angle <= -90 and look_angle >= -180 then
			--print("WALKING [SE] BACKWARD")
			return LanttuMeleeNerf.MoveDirection.BACKWARD
		end 
	elseif move_direction < -2.35 and move_direction > -2.36 then
		--print("WALKING [S]")
		if look_angle >= 45 and look_angle <= 135 then
			--print("WALKING [S] FORWARD")
			return LanttuMeleeNerf.MoveDirection.FORWARD
		elseif look_angle <= -45 and look_angle >= -135 then
			--print("WALKING [S] BACKWARD")
			return LanttuMeleeNerf.MoveDirection.BACKWARD
		end 
	elseif move_direction < -3.14 and move_direction > -3.15 then
		--print("WALKING [SW]")
		if look_angle <= 180 and look_angle >= 90 then
			--print("WALKING [SW] FORWARD")
			return LanttuMeleeNerf.MoveDirection.FORWARD
		elseif look_angle >= -90 and look_angle <= -0 then
			--print("WALKING [SW] BACKWARD")
			return LanttuMeleeNerf.MoveDirection.BACKWARD
		end 
	elseif move_direction > 2.35 and move_direction < 2.36 then
		--print("WALKING [W]")
		if (look_angle >= 135 and look_angle <= 180) or (look_angle <= -135 and look_angle >= -180) then
			--print("WALKING [W] FORWARD")
			return LanttuMeleeNerf.MoveDirection.FORWARD
		elseif look_angle >= -45 and look_angle <= 45 then
			--print("WALKING [W] BACKWARD")
			return LanttuMeleeNerf.MoveDirection.BACKWARD
		end 
	elseif move_direction > 1.57 and move_direction < 1.58 then
		--print("WALKING [NW]")
		if look_angle <= -90 and look_angle >= -180 then
			--print("WALKING [NW] FORWARD")
			return LanttuMeleeNerf.MoveDirection.FORWARD
		elseif look_angle >= 0 and look_angle <= 90 then
			--print("WALKING [NW] BACKWARD")
			return LanttuMeleeNerf.MoveDirection.BACKWARD
		end 
	end
	return LanttuMeleeNerf.MoveDirection.SIDEWAYS
end

LanttuMeleeNerf.isCriticalHit = function (hand_weapon, multiplier)
	local random = ZombRand(0,101)
	local hit_chance = hand_weapon:getCriticalChance() * multiplier
	return random <= hit_chance
end

LanttuMeleeNerf.initializeWeaponStats = function (hand_weapon)
	hand_weapon:getModData().meleenerf = {}
	hand_weapon:getModData().meleenerf.minDamage = hand_weapon:getMinDamage()
	hand_weapon:getModData().meleenerf.maxDamage = hand_weapon:getMaxDamage()
end

LanttuMeleeNerf.restoreWeaponStats = function (hand_weapon)
	hand_weapon:setMinDamage(hand_weapon:getModData().meleenerf.minDamage)
	hand_weapon:setMaxDamage(hand_weapon:getModData().meleenerf.maxDamage)
end

LanttuMeleeNerf.doNerf = function (character, hand_weapon)
	LanttuMeleeNerf.initializeWeaponStats(hand_weapon)
	hand_weapon:setMinDamage(hand_weapon:getModData().meleenerf.minDamage * SandboxVars.LanttuMeleeNerf.NerfWeaponMinDamageMultiplier)
	hand_weapon:setMaxDamage(hand_weapon:getModData().meleenerf.maxDamage * SandboxVars.LanttuMeleeNerf.NerfWeaponMaxDamageMultiplier)

	if LanttuMeleeNerf.isCriticalHit(hand_weapon, SandboxVars.LanttuMeleeNerf.NerfWeaponCriticalHitChanceMultiplier) then
		character:setCriticalHit(true)
	end
end

LanttuMeleeNerf.doBoost = function (character, hand_weapon)
	LanttuMeleeNerf.initializeWeaponStats(hand_weapon)
	hand_weapon:setMinDamage(hand_weapon:getModData().meleenerf.minDamage * SandboxVars.LanttuMeleeNerf.BoostWeaponMinDamageMultiplier)
	hand_weapon:setMaxDamage(hand_weapon:getModData().meleenerf.maxDamage * SandboxVars.LanttuMeleeNerf.BoostWeaponMaxDamageMultiplier)

	if LanttuMeleeNerf.isCriticalHit(hand_weapon, SandboxVars.LanttuMeleeNerf.BoostWeaponCriticalHitChanceMultiplier) then
		character:setCriticalHit(true)
	end
end

LanttuMeleeNerf.doBasic = function (character, hand_weapon)
	LanttuMeleeNerf.initializeWeaponStats(hand_weapon)
end

LanttuMeleeNerf.onWeaponSwing = function (character, hand_weapon)
	if not character or character:isDead() then return end
	if not hand_weapon then return end
	if hand_weapon:isRanged() then return end

	local walk_direction = LanttuMeleeNerf.walkDirection(character)
	if walk_direction == LanttuMeleeNerf.MoveDirection.FORWARD then
		LanttuMeleeNerf.doBoost(character, hand_weapon)
	elseif walk_direction == LanttuMeleeNerf.MoveDirection.BACKWARD then
		LanttuMeleeNerf.doNerf(character, hand_weapon)
	else
		LanttuMeleeNerf.doBasic(character, hand_weapon)
	end
end

LanttuMeleeNerf.onPlayerAttackFinished = function (character, hand_weapon)
	if not hand_weapon then return end
	if hand_weapon:isRanged() then return end
	LanttuMeleeNerf.restoreWeaponStats(hand_weapon)
end

LanttuMeleeNerf.initializeMod = function (character)
	Events.OnWeaponSwing.Add(LanttuMeleeNerf.onWeaponSwing)
	Events.OnPlayerAttackFinished.Add(LanttuMeleeNerf.onPlayerAttackFinished)
end

Events.OnGameStart.Add(LanttuMeleeNerf.initializeMod)