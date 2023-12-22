LanttuMeleeNerf = {}

LanttuMeleeNerf.MoveDirection = {
	STANDING = 0,
	SIDEWAYS = 1,
	FORWARD = 2,
	BACKWARD = 3
}

LanttuMeleeNerf.walkDirection = function (character)
	if not character:isPlayerMoving() then return LanttuMeleeNerf.MoveDirection.STADING end

	local direction = character:getPlayerMoveDir():getDirection();
	local look_angle = character:getDirectionAngle();
	
	if direction > 0.78 and direction < 0.79 then
		--print("WALKING [N]");
		if look_angle <= -45 and look_angle >= -135 then
			print("WALKING [N] FORWARD");
			return LanttuMeleeNerf.MoveDirection.FORWARD
		elseif look_angle >= 45 and look_angle <= 135 then
			print("WALKING [N] BACKWARD");
			return LanttuMeleeNerf.MoveDirection.BACKWARD
		end 
	elseif direction == 0 then
		--print("WALKING [NE]");
		if look_angle >= -90 and look_angle <= -0 then
			print("WALKING [NE] FORWARD");
			return LanttuMeleeNerf.MoveDirection.FORWARD
		elseif look_angle <= 180 and look_angle >= 90 then
			print("WALKING [NE] BACKWARD");
			return LanttuMeleeNerf.MoveDirection.BACKWARD
		end 
	elseif direction < -0.78 and direction > -0.79 then
		--print("WALKING [E]");
		if look_angle >= -45 and look_angle <= 45 then
			print("WALKING [E] FORWARD");
			return LanttuMeleeNerf.MoveDirection.FORWARD
		elseif (look_angle >= 135 and look_angle <= 180) or (look_angle <= -135 and look_angle >= -180) then
			print("WALKING [E] BACKWARD");
			return LanttuMeleeNerf.MoveDirection.BACKWARD
		end 
	elseif direction < -1.57 and direction > -1.58 then
		--print("WALKING [SE]");
		if look_angle >= 0 and look_angle <= 90 then
			print("WALKING [SE] FORWARD");
			return LanttuMeleeNerf.MoveDirection.FORWARD
		elseif look_angle <= -90 and look_angle >= -180 then
			print("WALKING [SE] BACKWARD");
			return LanttuMeleeNerf.MoveDirection.BACKWARD
		end 
	elseif direction < -2.35 and direction > -2.36 then
		--print("WALKING [S]");
		if look_angle >= 45 and look_angle <= 135 then
			print("WALKING [S] FORWARD");
			return LanttuMeleeNerf.MoveDirection.FORWARD
		elseif look_angle <= -45 and look_angle >= -135 then
			print("WALKING [S] BACKWARD");
			return LanttuMeleeNerf.MoveDirection.BACKWARD
		end 
	elseif direction < -3.14 and direction > -3.15 then
		--print("WALKING [SW]");
		if look_angle <= 180 and look_angle >= 90 then
			print("WALKING [SW] FORWARD");
			return LanttuMeleeNerf.MoveDirection.FORWARD
		elseif look_angle >= -90 and look_angle <= -0 then
			print("WALKING [SW] BACKWARD");
			return LanttuMeleeNerf.MoveDirection.BACKWARD
		end 
	elseif direction > 2.35 and direction < 2.36 then
		--print("WALKING [W]");
		if (look_angle >= 135 and look_angle <= 180) or (look_angle <= -135 and look_angle >= -180) then
			print("WALKING [W] FORWARD");
			return LanttuMeleeNerf.MoveDirection.FORWARD
		elseif look_angle >= -45 and look_angle <= 45 then
			print("WALKING [W] BACKWARD");
			return LanttuMeleeNerf.MoveDirection.BACKWARD
		end 
	elseif direction > 1.57 and direction < 1.58 then
		--print("WALKING [NW]");
		if look_angle <= -90 and look_angle >= -180 then
			print("WALKING [NW] FORWARD");
			return LanttuMeleeNerf.MoveDirection.FORWARD
		elseif look_angle >= 0 and look_angle <= 90 then
			print("WALKING [NW] BACKWARD");
			return LanttuMeleeNerf.MoveDirection.BACKWARD
		end 
	end
	return LanttuMeleeNerf.MoveDirection.SIDEWAYS
end

LanttuMeleeNerf.initializeCharacterAttack = function (character)
	--print(string.format('Orig CRIT [%f]', hand_weapon:getCriticalChance()));
	--print(string.format('Orig KnockDown [%s]', tostring(hand_weapon:isAlwaysKnockdown())));
	--print(string.format('Orig minDamage [%f]', hand_weapon:getMinDamage()));
	--print(string.format('Orig maxDamage [%f]', hand_weapon:getMaxDamage()));
	local walk_direction = LanttuMeleeNerf.walkDirection(character);
	
	if walk_direction ~= LanttuMeleeNerf.MoveDirection.FORWARD then
		character:setCriticalHit(false);
	end

	character:getModData().meleenerf = {}
	character:getModData().meleenerf.walk_direction = walk_direction;
end

LanttuMeleeNerf.releaseCharacterAttack = function (character)
	--print(string.format('Orig CRIT [%f]', hand_weapon:getCriticalChance()));
	--print(string.format('Orig KnockDown [%s]', tostring(hand_weapon:isAlwaysKnockdown())));
	--print(string.format('Orig minDamage [%f]', hand_weapon:getMinDamage()));
	--print(string.format('Orig maxDamage [%f]', hand_weapon:getMaxDamage()));
	character:getModData().meleenerf = {}
end

LanttuMeleeNerf.initializeWeaponStats = function (hand_weapon)
	--print(string.format('Orig CRIT [%f]', hand_weapon:getCriticalChance()));
	--print(string.format('Orig KnockDown [%s]', tostring(hand_weapon:isAlwaysKnockdown())));
	--print(string.format('Orig minDamage [%f]', hand_weapon:getMinDamage()));
	--print(string.format('Orig maxDamage [%f]', hand_weapon:getMaxDamage()));
	
	hand_weapon:getModData().meleenerf = {}
	hand_weapon:getModData().meleenerf.criticalChance = hand_weapon:getCriticalChance();
	hand_weapon:getModData().meleenerf.isAlwaysKnockdown = hand_weapon:isAlwaysKnockdown();
	hand_weapon:getModData().meleenerf.minDamage = hand_weapon:getMinDamage();
	hand_weapon:getModData().meleenerf.maxDamage = hand_weapon:getMaxDamage();
	hand_weapon:getModData().meleenerf.knockbackOnNoDeath = hand_weapon:isKnockBackOnNoDeath();
end

LanttuMeleeNerf.restoreWeaponStats = function (hand_weapon)
	--print(string.format('Restore CRIT [%f] -> [%f]', hand_weapon:getCriticalChance(), hand_weapon:getModData().meleenerf.criticalChance));
	--print(string.format('Restore KnockDown [%s] -> [%s]', tostring(hand_weapon:isAlwaysKnockdown()), tostring(hand_weapon:getModData().meleenerf.isAlwaysKnockdown)));
	--print(string.format('Restore minDamage [%f] -> [%f]', hand_weapon:getMinDamage(), hand_weapon:getModData().meleenerf.minDamage));
	--print(string.format('Restore maxDamage [%f] -> [%f]', hand_weapon:getMaxDamage(), hand_weapon:getModData().meleenerf.maxDamage));
	hand_weapon:setCriticalChance(hand_weapon:getModData().meleenerf.criticalChance);
	hand_weapon:setAlwaysKnockdown(hand_weapon:getModData().meleenerf.isAlwaysKnockdown);
	hand_weapon:setMinDamage(hand_weapon:getModData().meleenerf.minDamage);
	hand_weapon:setMaxDamage(hand_weapon:getModData().meleenerf.maxDamage);
	hand_weapon:setKnockBackOnNoDeath(hand_weapon:getModData().meleenerf.knockbackOnNoDeath);
end

LanttuMeleeNerf.doNerf = function (character, hand_weapon)
	print("NERF NERF");
	LanttuMeleeNerf.initializeWeaponStats(hand_weapon);
	hand_weapon:setCriticalChance(0);
	hand_weapon:setAlwaysKnockdown(false);
	hand_weapon:setMinDamage(hand_weapon:getModData().meleenerf.minDamage * 0);
	hand_weapon:setMaxDamage(hand_weapon:getModData().meleenerf.maxDamage * 0);
	hand_weapon:setKnockBackOnNoDeath(false);
end

LanttuMeleeNerf.doBoost = function (character, hand_weapon)
	print("BOOST BOOST");
	LanttuMeleeNerf.doNerf(character, hand_weapon);
	--LanttuMeleeNerf.initializeWeaponStats(hand_weapon);
	--hand_weapon:setCriticalChance(100);
	--hand_weapon:setAlwaysKnockdown(true);
	--hand_weapon:setMinDamage(hand_weapon:getModData().meleenerf.minDamage * 3);
	--hand_weapon:setMaxDamage(hand_weapon:getModData().meleenerf.maxDamage * 3);
end

LanttuMeleeNerf.doBasic = function (character, hand_weapon)
	print("DO BASIC");
	--LanttuMeleeNerf.initializeWeaponStats(hand_weapon);
	LanttuMeleeNerf.doNerf(character, hand_weapon);
end

LanttuMeleeNerf.OnWeaponSwing = function (character, hand_weapon)
	if not character or character:isDead() then return end;
	if not hand_weapon then return end;
	if hand_weapon:isRanged() then return end;

	LanttuMeleeNerf.initializeCharacterAttack(character);
end

LanttuMeleeNerf.OnWeaponSwingHitPoint = function (character, hand_weapon)
	if not character or character:isDead() then return end;
	if not hand_weapon then return end;
	if hand_weapon:isRanged() then return end;

	local move_direction = character:getModData().meleenerf.walk_direction;
	if move_direction == LanttuMeleeNerf.MoveDirection.FORWARD then
		LanttuMeleeNerf.doBoost(character, hand_weapon);
	elseif move_direction == LanttuMeleeNerf.MoveDirection.BACKWARD then
		LanttuMeleeNerf.doNerf(character, hand_weapon);
	else
		LanttuMeleeNerf.doBasic(character, hand_weapon)
	end
end

LanttuMeleeNerf.OnPlayerAttackFinished = function (character, hand_weapon)
	if not character or character:isDead() then return end;
	if not hand_weapon then return end;
	if hand_weapon:isRanged() then return end;
	LanttuMeleeNerf.releaseCharacterAttack(character);
	LanttuMeleeNerf.restoreWeaponStats(hand_weapon);
end

LanttuMeleeNerf.OnWeaponHitCharacter = function (actor, target, weapon, damage)
	if not actor then return end;
	if not target then return end;
	if not weapon then return end;
	--print("OnWeaponHitCharacter - actor[" ..actor.. "], target[" ..target.. "], weapon[" ..weapon.. "], damage[" ..damage.. "]")
	print(string.format('HIT WITH DAMAGE [%s] HEALTH: [%f] isDEAD: %s', tostring(damage or "nil"), target:getHealth(), tostring(target:isDead())));
end

LanttuMeleeNerf.OnHitZombie = function (zombie, character, body_part_type, hand_weapon)
	if not zombie then return end;
	if not character then return end;
	if not hand_weapon then return end;
	print("OnHitZombie");
	print(string.format('Zombie HEALTH: %f', zombie:getHealth()));
	--print("OnHitZombie - zombie[" ..zombie.. "], character[" ..character.. "], bodyPartType[" ..body_part_type.. "], handWeapon[" ..hand_weapon.."]")
end

LanttuMeleeNerf.OnPlayerMove = function (character)
	if character:isAiming() then
		--print(string.format('knockbackAttachMod: %f', character:knockbackAttackMod()));
		--LanttuMeleeNerf.walkDirection(character);
		--local move_dir_x = player:getPlayerMoveDir():getX();
		--local move_dir_y = player:getPlayerMoveDir():getY();
		--local direction = character:getPlayerMoveDir():getDirection();
		--local direction_angle = character:getDirectionAngle();
		--local last_angle = player:getLastAngle():getDirection();
		--local aim_dir_x = player:getAimVector():getX();
		--local aim_dir_y = player:getAimVector():getY();
		--print(string.format('DIRECTION ANGLE [%f] DIRECTION [%f]', direction_angle, direction));
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

LanttuMeleeNerf.AddXP = function (character, perk, level)
	print(string.format("XP GAINED [%f]", level));
end

LanttuMeleeNerf.InitializeEvents = function (player)

end

print("Lanttuchef's Melee weapon initialize events")
Events.OnWeaponSwing.Add(LanttuMeleeNerf.OnWeaponSwing);
Events.OnWeaponSwingHitPoint.Add(LanttuMeleeNerf.OnWeaponSwingHitPoint);
Events.OnWeaponHitCharacter.Add(LanttuMeleeNerf.OnWeaponHitCharacter);
Events.OnHitZombie.Add(LanttuMeleeNerf.OnHitZombie);
Events.OnPlayerAttackFinished.Add(LanttuMeleeNerf.OnPlayerAttackFinished);
Events.OnPlayerMove.Add(LanttuMeleeNerf.OnPlayerMove);
Events.OnPlayerUpdate.Add(LanttuMeleeNerf.OnPlayerUpdate);
Events.AddXP.Add(LanttuMeleeNerf.AddXP);


Events.OnGameStart.Add(LanttuMeleeNerf.InitializeEvents)