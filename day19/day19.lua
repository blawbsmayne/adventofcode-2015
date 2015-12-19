io.input("input.txt")

rules = {}
mol = ""


--parse the puzzle input
pRules = true
while true do
  local l = io.read("*line")
  if l == nil then break end
  if l == "" then pRules = false end

  if pRules then
    local rule = {}
    rule.prem, rule.con = l:match("(%a+) => (%a+)")
    table.insert(rules, rule)
  else
    if l ~= "" then
      mol = l
    end
  end
end

--do all replacements, put strings in set, count set
-- -- this went better than expected..
molecules = {}
for _,rule in pairs(rules) do
  local ind = 1
  while true do
    local a,b = mol:find(rule.prem, ind)
    if a == nil then break end
    local newStr = mol:sub(1,a-1) .. rule.con
    if b < #mol then
      newStr = newStr .. mol:sub(b+1,#mol)
    end
    molecules[newStr] = true
    ind = b+1
  end
end

count = 0
for _,_ in pairs(molecules) do
  count = count + 1
end

print("Part 1: " .. count)


--now let's break everything
function part2()
  local intermediates = {mol}
  local replacements = 0

  local found = false
  while found == false do
    if #intermediates == 0 then break end -- TODO
    replacements = replacements + 1

    local newIms = {}
    for _,im in pairs(intermediates) do -- for each intermediate "molecule"

      for _,rule in pairs(rules) do -- for each rule

        local ind = 1
        while true do -- try all replacements
          local a,b = im:find(rule.con, ind)
          if a == nil then break end
          local newStr = im:sub(1,a-1) .. rule.prem
          if b < #im then
            newStr = newStr .. im:sub(b+1,#im)
          end
          if newStr == "e" then
            found = true
            --print("Found!")
            break
          end
          table.insert(newIms, newStr)
          ind = b+1
        end
      end
    end
    table.sort(newIms, function(a,b) return #a<#b end)

    -- for some magical reason, it works to continue with the shortest word only
    intermediates = {newIms[1]}
  end

  return replacements
end

print("Part 2: " .. part2())
