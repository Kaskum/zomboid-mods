LanttuMeleeTweak = {}

LanttuMeleeTweak.MoveDirection = {
  STANDING = 0,
  SIDEWAYS = 1,
  FORWARD = 2,
  BACKWARD = 3
}

LanttuMeleeTweak.walkDirection = function (character)
  if not character:isPlayerMoving() then return LanttuMeleeTweak.MoveDirection.STANDING end

  local move_direction = character:getPlayerMoveDir():getDirection()
  local look_angle = character:getDirectionAngle()
  
  if move_direction > 0.78 and move_direction < 0.79 then
    --print("WALKING [N]")
    if look_angle <= -45 and look_angle >= -135 then
      --print("WALKING [N] FORWARD")
      return LanttuMeleeTweak.MoveDirection.FORWARD
    elseif look_angle >= 45 and look_angle <= 135 then
      --print("WALKING [N] BACKWARD")
      return LanttuMeleeTweak.MoveDirection.BACKWARD
    end 
  elseif move_direction == 0 then
    --print("WALKING [NE]")
    if look_angle >= -90 and look_angle <= -0 then
      --print("WALKING [NE] FORWARD")
      return LanttuMeleeTweak.MoveDirection.FORWARD
    elseif look_angle <= 180 and look_angle >= 90 then
      --print("WALKING [NE] BACKWARD")
      return LanttuMeleeTweak.MoveDirection.BACKWARD
    end 
  elseif move_direction < -0.78 and move_direction > -0.79 then
    --print("WALKING [E]")
    if look_angle >= -45 and look_angle <= 45 then
      --print("WALKING [E] FORWARD")
      return LanttuMeleeTweak.MoveDirection.FORWARD
    elseif (look_angle >= 135 and look_angle <= 180) or (look_angle <= -135 and look_angle >= -180) then
      --print("WALKING [E] BACKWARD")
      return LanttuMeleeTweak.MoveDirection.BACKWARD
    end 
  elseif move_direction < -1.57 and move_direction > -1.58 then
    --print("WALKING [SE]")
    if look_angle >= 0 and look_angle <= 90 then
      --print("WALKING [SE] FORWARD")
      return LanttuMeleeTweak.MoveDirection.FORWARD
    elseif look_angle <= -90 and look_angle >= -180 then
      --print("WALKING [SE] BACKWARD")
      return LanttuMeleeTweak.MoveDirection.BACKWARD
    end 
  elseif move_direction < -2.35 and move_direction > -2.36 then
    --print("WALKING [S]")
    if look_angle >= 45 and look_angle <= 135 then
      --print("WALKING [S] FORWARD")
      return LanttuMeleeTweak.MoveDirection.FORWARD
    elseif look_angle <= -45 and look_angle >= -135 then
      --print("WALKING [S] BACKWARD")
      return LanttuMeleeTweak.MoveDirection.BACKWARD
    end 
  elseif move_direction < -3.14 and move_direction > -3.15 then
    --print("WALKING [SW]")
    if look_angle <= 180 and look_angle >= 90 then
      --print("WALKING [SW] FORWARD")
      return LanttuMeleeTweak.MoveDirection.FORWARD
    elseif look_angle >= -90 and look_angle <= -0 then
      --print("WALKING [SW] BACKWARD")
      return LanttuMeleeTweak.MoveDirection.BACKWARD
    end 
  elseif move_direction > 2.35 and move_direction < 2.36 then
    --print("WALKING [W]")
    if (look_angle >= 135 and look_angle <= 180) or (look_angle <= -135 and look_angle >= -180) then
      --print("WALKING [W] FORWARD")
      return LanttuMeleeTweak.MoveDirection.FORWARD
    elseif look_angle >= -45 and look_angle <= 45 then
      --print("WALKING [W] BACKWARD")
      return LanttuMeleeTweak.MoveDirection.BACKWARD
    end 
  elseif move_direction > 1.57 and move_direction < 1.58 then
    --print("WALKING [NW]")
    if look_angle <= -90 and look_angle >= -180 then
      --print("WALKING [NW] FORWARD")
      return LanttuMeleeTweak.MoveDirection.FORWARD
    elseif look_angle >= 0 and look_angle <= 90 then
      --print("WALKING [NW] BACKWARD")
      return LanttuMeleeTweak.MoveDirection.BACKWARD
    end 
  end
  return LanttuMeleeTweak.MoveDirection.SIDEWAYS
end

LanttuMeleeTweak.isCriticalHit = function (hand_weapon, multiplier)
  local random = ZombRand(0,101)
  local hit_chance = hand_weapon:getCriticalChance() * multiplier
  return random <= hit_chance
end

LanttuMeleeTweak.initializeWeaponStats = function (hand_weapon)
  hand_weapon:getModData().meleetweak = {}
  hand_weapon:getModData().meleetweak.minDamage = hand_weapon:getMinDamage()
  hand_weapon:getModData().meleetweak.maxDamage = hand_weapon:getMaxDamage()
end

LanttuMeleeTweak.restoreWeaponStats = function (hand_weapon)
  hand_weapon:setMinDamage(hand_weapon:getModData().meleetweak.minDamage)
  hand_weapon:setMaxDamage(hand_weapon:getModData().meleetweak.maxDamage)
end

LanttuMeleeTweak.doBackward = function (character, hand_weapon)
  LanttuMeleeTweak.initializeWeaponStats(hand_weapon)
  hand_weapon:setMinDamage(hand_weapon:getModData().meleetweak.minDamage * SandboxVars.LanttuMeleeTweak.BackwardWeaponMinDamageMultiplier)
  hand_weapon:setMaxDamage(hand_weapon:getModData().meleetweak.maxDamage * SandboxVars.LanttuMeleeTweak.BackwardWeaponMaxDamageMultiplier)

  if LanttuMeleeTweak.isCriticalHit(hand_weapon, SandboxVars.LanttuMeleeTweak.BackwardWeaponCriticalHitChanceMultiplier) then
    character:setCriticalHit(true)
  end
end

LanttuMeleeTweak.doForward = function (character, hand_weapon)
  LanttuMeleeTweak.initializeWeaponStats(hand_weapon)
  hand_weapon:setMinDamage(hand_weapon:getModData().meleetweak.minDamage * SandboxVars.LanttuMeleeTweak.ForwardWeaponMinDamageMultiplier)
  hand_weapon:setMaxDamage(hand_weapon:getModData().meleetweak.maxDamage * SandboxVars.LanttuMeleeTweak.ForwardWeaponMaxDamageMultiplier)

  if LanttuMeleeTweak.isCriticalHit(hand_weapon, SandboxVars.LanttuMeleeTweak.ForwardWeaponCriticalHitChanceMultiplier) then
    character:setCriticalHit(true)
  end
end

LanttuMeleeTweak.doDefault = function (character, hand_weapon)
  LanttuMeleeTweak.initializeWeaponStats(hand_weapon)
end

LanttuMeleeTweak.onWeaponSwing = function (character, hand_weapon)
  if not character or character:isDead() then return end
  if not hand_weapon then return end
  if hand_weapon:isRanged() then return end

  local walk_direction = LanttuMeleeTweak.walkDirection(character)
  if walk_direction == LanttuMeleeTweak.MoveDirection.FORWARD then
    LanttuMeleeTweak.doForward(character, hand_weapon)
  elseif walk_direction == LanttuMeleeTweak.MoveDirection.BACKWARD then
    LanttuMeleeTweak.doBackward(character, hand_weapon)
  else
    LanttuMeleeTweak.doDefault(character, hand_weapon)
  end
end

LanttuMeleeTweak.onPlayerAttackFinished = function (character, hand_weapon)
  if not hand_weapon then return end
  if hand_weapon:isRanged() then return end
  LanttuMeleeTweak.restoreWeaponStats(hand_weapon)
end

LanttuMeleeTweak.initializeMod = function (character)
  Events.OnWeaponSwing.Add(LanttuMeleeTweak.onWeaponSwing)
  Events.OnPlayerAttackFinished.Add(LanttuMeleeTweak.onPlayerAttackFinished)
end

Events.OnGameStart.Add(LanttuMeleeTweak.initializeMod)