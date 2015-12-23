cost = {53, 73, 113, 173, 229}

--part = 1 -- 1 or 2

function play(pSpell, pHP, pMana, pBossHP, pShield, pPoison, pRecharge, pSpent)

  if part == 2 then
    pHP = pHP - 1
    if pHP <= 0 then return end
  end

  pBossHP, pPoison, pMana, pRecharge, pShield = effects(pBossHP, pPoison, pMana, pRecharge, pShield)

  if pBossHP <= 0 then
    updateResult(pSpent)
    return
  end
  if pMana <= 0 then return end

  if pSpell == 1 then
    pBossHP = pBossHP - 4
  elseif pSpell == 2 then
    pBossHP = pBossHP - 2
    pHP = pHP + 2
  elseif pSpell == 3 then
    if pShield > 0 then return end
    pShield = 6
  elseif pSpell == 4 then
    if pPoison > 0 then return end
    pPoison = 6
  elseif pSpell == 5 then
    if pRecharge > 0 then return end
    pRecharge = 5
  end

  --update mana
  pMana = pMana - cost[pSpell]
  pSpent = pSpent + cost[pSpell]
  if pMana < 0 then return end

  --boss turn
  if pBossHP > 0 then
    if pShield > 0 then
      pHP = pHP - 3
    else
      pHP = pHP - 10
    end
  end

  pBossHP, pPoison, pMana, pRecharge, pShield = effects(pBossHP, pPoison, pMana, pRecharge, pShield)

  if pBossHP <= 0 then
    updateResult(pSpent)
    return
  end

  if pHP <= 0 then return end

  for i = 1,5 do
    play(i, pHP, pMana, pBossHP, pShield, pPoison, pRecharge, pSpent)
  end
end

function effects(pBossHP, pPoison, pMana, pRecharge, pShield)
  if pPoison > 0 then
    pBossHP = pBossHP - 3
    pPoison = pPoison - 1
  end
  if pRecharge > 0 then
    pMana = pMana + 101
    pRecharge = pRecharge - 1
  end
  if pShield > 0 then pShield = pShield - 1 end
  return pBossHP, pPoison, pMana, pRecharge, pShield
end

function updateResult(pSpent)
  if minSpent == nil then
    minSpent = pSpent
  else
    minSpent = math.min(pSpent, minSpent)
  end
end

-- ##########

part = 1
for i=1,5 do
  play(i, 50, 500, 71, 0, 0, 0, 0)
end
print("Part "..part..": "..minSpent)

minSpent = nil

part = 2
for i=1,5 do
  play(i, 50, 500, 71, 0, 0, 0, 0)
end
print("Part "..part..": "..minSpent)
