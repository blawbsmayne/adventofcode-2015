io.input("input.txt")

-- http://www.lua.org/pil/9.3.html
function permgen (a, n)
  if n == 0 then
    coroutine.yield(a)
  else
    for i=1,n do
      a[n], a[i] = a[i], a[n]
      permgen(a, n - 1)
      a[n], a[i] = a[i], a[n]
    end
  end
end
function perm(a)
  local n = #a
  local co = coroutine.create(function () permgen(a, n) end)
  return function ()
    local code, res = coroutine.resume(co)
    return res
  end
end
--end http://www.lua.org/pil/9.3.html

preferences = {}
persons = {}
sequence = {}

-- parse file and fill preferences
while true do
  local l = io.read("*line")
  if l == nil then break end

  local lose = l:find("gain")==nil

  local a,b = l:find("%a+%s")
  local person1 = l:sub(a,b-1)

  a,b = l:find("%d+")
  local happiness = tonumber(l:sub(a,b))

  a,b = l:find("%a+%.")
  local person2 = l:sub(a,b-1)

  if preferences[person1] == nil then preferences[person1] = {} end
  if lose then happiness = -1 * happiness end
  preferences[person1][person2] = happiness

  persons[person1] = true
  persons[person2] = true
end

for person, _ in pairs(persons) do
  table.insert(sequence, person)
end

--try all permutations
--also (unnecessarily) tries all rotations around the table
-- -- one could fix the first person to save around (n-1)/n calculations
-- -- (for each permutation there are n-1 rotations of equal value)
-- -- since this is O(n!), we wouldn't save much ntl
function maximizeHappiness(prefs, seq)
  local maxHappiness = 0
  for per in perm(seq) do
    local happ = 0
    for i=1,#per do
      if i == 1 then -- this works, ok?
        happ = happ + prefs[per[1]][per[#per]] + prefs[per[1]][per[2]]
      elseif i == #per then
        happ = happ + prefs[per[i]][per[i-1]] + prefs[per[i]][per[1]]
      else
        happ = happ + prefs[per[i]][per[i-1]] + prefs[per[i]][per[i+1]]
      end
    end
    maxHappiness = math.max(maxHappiness,happ)
  end
  return maxHappiness
end

print("The maximum happiness is "..maximizeHappiness(preferences, sequence))

myself = "Myself"
preferences[myself] = {}
for person,_ in pairs(persons) do
  preferences[myself][person] = 0
  preferences[person][myself] = 0
end
table.insert(sequence, myself)

print("I'm changing the happiness to "..maximizeHappiness(preferences, sequence))

print("I guess they're doing fine without me O_O")
