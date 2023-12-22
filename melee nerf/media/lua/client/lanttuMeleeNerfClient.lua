LanttuMeleeNerf = {}

--LanttuMeleeNerf.MoveDirection = {
--	STILL = 0,
--	FORWARD = 1,
--	BACKWARD = 2
--}

LanttuMeleeNerf.OnWeaponSwing = function (character, hand_weapon)
	--print("dsmmsd " ..character:getDisplayName());
end

LanttuMeleeNerf.walkDirection = function (character)
	local direction = character:getPlayerMoveDir():getDirection();
	local look_angle = character:getDirectionAngle();
	
	if direction > 0.78 and direction < 0.79 then
		--print("WALKING [N]");
		if look_angle <= -45 and look_angle >= -135 then
			print("WALKING [N] FORWARD");
		elseif look_angle >= 45 and look_angle <= 135 then
			print("WALKING [N] BACKWARD");
		end 
	elseif direction == 0 then
		--print("WALKING [NE]");
		if look_angle >= -90 and look_angle <= -0 then
			print("WALKING [NE] FORWARD");
		elseif look_angle <= 180 and look_angle >= 90 then
			print("WALKING [NE] BACKWARD");
		end 
	elseif direction < -0.78 and direction > -0.79 then
		--print("WALKING [E]");
		if look_angle >= -45 and look_angle <= 45 then
			print("WALKING [E] FORWARD");
		elseif (look_angle >= 135 and look_angle <= 180) or (look_angle <= -135 and look_angle >= -180) then
			print("WALKING [E] BACKWARD");
		end 
	elseif direction < -1.57 and direction > -1.58 then
		--print("WALKING [SE]");
		if look_angle >= 0 and look_angle <= 90 then
			print("WALKING [SE] FORWARD");
		elseif look_angle <= -90 and look_angle >= -180 then
			print("WALKING [SE] BACKWARD");
		end 
	elseif direction < -2.35 and direction > -2.36 then
		--print("WALKING [S]");
		if look_angle >= 45 and look_angle <= 135 then
			print("WALKING [S] FORWARD");
		elseif look_angle <= -45 and look_angle >= -135 then
			print("WALKING [S] BACKWARD");
		end 
	elseif direction < -3.14 and direction > -3.15 then
		--print("WALKING [SW]");
		if look_angle <= 180 and look_angle >= 90 then
			print("WALKING [SW] FORWARD");
		elseif look_angle >= -90 and look_angle <= -0 then
			print("WALKING [SW] BACKWARD");
		end 
	elseif direction > 2.35 and direction < 2.36 then
		--print("WALKING [W]");
		if (look_angle >= 135 and look_angle <= 180) or (look_angle <= -135 and look_angle >= -180) then
			print("WALKING [W] FORWARD");
		elseif look_angle >= -45 and look_angle <= 45 then
			print("WALKING [W] BACKWARD");
		end 
	elseif direction > 1.57 and direction < 1.58 then
		--print("WALKING [NW]");
		if look_angle <= -90 and look_angle >= -180 then
			print("WALKING [NW] FORWARD");
		elseif look_angle >= 0 and look_angle <= 90 then
			print("WALKING [NW] BACKWARD");
		end 
	end
end

LanttuMeleeNerf.initializeWeaponStats = function (hand_weapon)
	print(string.format('Orig CRIT [%f]', hand_weapon:getCriticalChance()));
	print(string.format('Orig KnockDown [%s]', tostring(hand_weapon:isAlwaysKnockdown())));
	print(string.format('Orig minDamage [%f]', hand_weapon:getMinDamage()));
	print(string.format('Orig maxDamage [%f]', hand_weapon:getMaxDamage()));
	
	hand_weapon:getModData().meleenerf = {}
	hand_weapon:getModData().meleenerf.criticalChance = hand_weapon:getCriticalChance();
	hand_weapon:getModData().meleenerf.isAlwaysKnockdown = hand_weapon:isAlwaysKnockdown();
	hand_weapon:getModData().meleenerf.minDamage = hand_weapon:getMinDamage();
	hand_weapon:getModData().meleenerf.maxDamage = hand_weapon:getMaxDamage();
end

LanttuMeleeNerf.restoreWeaponStats = function (hand_weapon)
	print(string.format('Restore CRIT [%f] -> [%f]', hand_weapon:getCriticalChance(), hand_weapon:getModData().meleenerf.criticalChance));
	print(string.format('Restore KnockDown [%s] -> [%s]', tostring(hand_weapon:isAlwaysKnockdown()), tostring(hand_weapon:getModData().meleenerf.isAlwaysKnockdown)));
	print(string.format('Restore minDamage [%f] -> [%f]', hand_weapon:getMinDamage(), hand_weapon:getModData().meleenerf.minDamage));
	print(string.format('Restore maxDamage [%f] -> [%f]', hand_weapon:getMaxDamage(), hand_weapon:getModData().meleenerf.maxDamage));
	hand_weapon:setCriticalChance(hand_weapon:getModData().meleenerf.criticalChance);
	hand_weapon:setAlwaysKnockdown(hand_weapon:getModData().meleenerf.isAlwaysKnockdown);
	hand_weapon:setMinDamage(hand_weapon:getModData().meleenerf.minDamage);
	hand_weapon:setMaxDamage(hand_weapon:getModData().meleenerf.maxDamage);
end

LanttuMeleeNerf.OnWeaponSwingHitPoint = function (character, hand_weapon)

	print(string.format("weapon max angle [%f]", hand_weapon:getMaxAngle()));
	if character:isPlayerMoving() then
		if not hand_weapon:isRanged() then
			LanttuMeleeNerf.initializeWeaponStats(hand_weapon);
			print("MAYBE NERF OR BOOST");
			local move_dir_x = character:getPlayerMoveDir():getX();
			local move_dir_y = character:getPlayerMoveDir():getY();
			local direction = character:getPlayerMoveDir():getDirection();
			local direction_angle = character:getDirectionAngle();
			local last_angle = character:getLastAngle():getDirection();
			local aiming_mod = character:getAimingMod();
			local critical_chance = hand_weapon:getCriticalChance();

			hand_weapon:setCriticalChance(10);
			--local aim_dir_x = player:getAimVector():getX();
			--local aim_dir_y = player:getAimVector():getY();
			--print(string.format('DIRECTION ANGLE [%f] DIRECTION [%f] AMOD [%f]', direction_angle, direction, aiming_mod));
			--print(string.format('CRITICAL CHANCE [%f]', critical_chance));
		end
	elseif not hand_weapon:isRanged() then
		LanttuMeleeNerf.initializeWeaponStats(hand_weapon);
		print("GO WITH BASICS");
		local critical_chance = hand_weapon:getCriticalChance();
		print(string.format('CRITICAL CHANCE [%f]', critical_chance));
	end
end

LanttuMeleeNerf.OnPlayerAttackFinished = function (character, hand_weapon)
	if not hand_weapon:isRanged() then
		LanttuMeleeNerf.restoreWeaponStats(hand_weapon);
	end
end

LanttuMeleeNerf.OnWeaponHitCharacter = function (actor, target, weapon, damage)
	--print("OnWeaponHitCharacter - actor[" ..actor.. "], target[" ..target.. "], weapon[" ..weapon.. "], damage[" ..damage.. "]")
	print(string.format('HIT WITH DAMAGE [%f]', damage));
end

LanttuMeleeNerf.OnHitZombie = function (zombie, character, body_part_type, hand_weapon)
	--print("OnHitZombie - zombie[" ..zombie.. "], character[" ..character.. "], bodyPartType[" ..body_part_type.. "], handWeapon[" ..hand_weapon.."]")
end

LanttuMeleeNerf.OnPlayerMove = function (character)
	if character:isAiming() then
		LanttuMeleeNerf.walkDirection(character);
		--local move_dir_x = player:getPlayerMoveDir():getX();
		--local move_dir_y = player:getPlayerMoveDir():getY();
		local direction = character:getPlayerMoveDir():getDirection();
		local direction_angle = character:getDirectionAngle();
		--local last_angle = player:getLastAngle():getDirection();
		--local aim_dir_x = player:getAimVector():getX();
		--local aim_dir_y = player:getAimVector():getY();
		print(string.format('DIRECTION ANGLE [%f] DIRECTION [%f]', direction_angle, direction));
	end
end

LanttuMeleeNerf.OnPlayerUpdate = function (player)
	--if player:isAiming() then
		--print("MOVING AND AIMING" ..player:getDisplayName().." DIRECTION ANGLE: " ..player:getDirectionAngle());
		--local direction_angle = player:getDirectionAngle();
		--local last_angle = player:getLastAngle():getDirection();
		--local aim_dir_x = player:getAimVector():getX();
		--local aim_dir_y = player:getAimVector():getY();
		
		--print(string.format('ON PLAYUPDATE DIRECTION ANGLE [%f] last_angle [%f]', direction_angle, last_angle));
	--end
end

LanttuMeleeNerf.InitializeEvents = function (player)

end

print("Lanttuchef's Melee weapon initialize events")
Events.OnWeaponSwing.Add(LanttuMeleeNerf.OnWeaponSwing);
Events.OnWeaponSwingHitPoint.Add(LanttuMeleeNerf.OnWeaponSwingHitPoint);
Events.OnWeaponHitCharacter.Add(LanttuMeleeNerf.OnWeaponHitCharacter);
Events.OnHitZombie.Add(LanttuMeleeNerf.OnWeaponHitCharacter);
Events.OnPlayerAttackFinished.Add(LanttuMeleeNerf.OnPlayerAttackFinished);
Events.OnPlayerMove.Add(LanttuMeleeNerf.OnPlayerMove);
Events.OnPlayerUpdate.Add(LanttuMeleeNerf.OnPlayerUpdate);


Events.OnGameStart.Add(LanttuMeleeNerf.InitializeEvents)