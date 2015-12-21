boss = {}
boss.hp, boss.dmg, boss.def = 104, 8, 1

weapons = {{8,4},{10,5},{25,6},{40,7},{74,8}}
armor = {{0,0},{13,1},{31,2},{53,3},{75,4},{102,5}}
rings = {{25,1,0},{50,2,0},{100,3,0},{20,0,1},{40,0,2},{80,0,3}}

me = {}
me.hp, me.dmg, me.def = 100, 0, 0
ring1 = 0
ring2 = 0

optCost = 9999999
worstCost = 0

function doIWinYet(c)
  local bossGetsDmg = math.max(me.dmg - boss.def, 1)
  local meGetsDmg = math.max(boss.dmg - me.def, 1)
  local bossDeadAfter = math.ceil(boss.hp / bossGetsDmg)
  local meDeadAfter = math.ceil(me.hp / meGetsDmg)
  --return meDeadAfter >= bossDeadAfter
  if meDeadAfter >= bossDeadAfter then
    optCost = math.min(optCost, c)
  end

  --Part 2
  if meDeadAfter < bossDeadAfter then
    worstCost = math.max(worstCost, c)
  end
end

--simply try everything - the input complexity is low today
cost = 0
for _,w in ipairs(weapons) do
  cost = cost + w[1]
  me.dmg = me.dmg + w[2]
  for _,a in ipairs(armor) do
    cost = cost + a[1]
    me.def = me.def + a[2]

    for i,r in ipairs(rings) do
      cost = cost + r[1]
      me.dmg = me.dmg + r[2]
      me.def = me.def + r[3]

      doIWinYet(cost)
      if i < #rings then
        for j = i+1, #rings do
          cost = cost + rings[j][1]
          me.dmg = me.dmg + rings[j][2]
          me.def = me.def + rings[j][3]
          doIWinYet(cost)
          me.def = me.def - rings[j][3]
          me.dmg = me.dmg - rings[j][2]
          cost = cost - rings[j][1]
        end
      end

      me.def = me.def - r[3]
      me.dmg = me.dmg - r[2]
      cost = cost - r[1]
    end

    me.def = me.def - a[2]
    cost = cost - a[1]
  end
  me.dmg = me.dmg - w[2]
  cost = cost - w[1]
end

print("Part 1: "..optCost)
print("Part 2: "..worstCost)
