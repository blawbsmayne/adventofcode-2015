io.input("input.txt")

sue = {["children"]=3,["cats"]=7,["samoyeds"]=2,["pomeranians"]=3,["akitas"]=0,["vizslas"]=0,["goldfish"]=5,["trees"]=3,["cars"]=2,["perfumes"]=1}

while true do
  local l = io.read("*line")
  if l == nil then break end

  local isSue = true
  for k,v in pairs(sue) do
    local a,b = l:find(k)
    if a ~= nil then
      local number = tonumber(l:match("%d+", b+3))
      if number ~= v then
        isSue = false
        break
      end
    end
  end

  if isSue then
    print("Correct Sue is "..l:match("(Sue %d+)"))
    break
  end
end

--let's start over for part 2

io.input("input.txt")

while true do
  local l = io.read("*line")
  if l == nil then break end

  local isSue = true
  for k,v in pairs(sue) do
    local a,b = l:find(k)
    if a ~= nil then
      local number = tonumber(l:match("%d+", b+3))
      if k == "cats" or k == "trees" then
        if number <= v then
          isSue = false
          break
        end
      elseif k == "pomeranians" or k == "goldfish" then
        if number >= v then
          isSue = false
          break
        end
      else
        if number ~= v then
          isSue = false
          break
        end
      end
    end
  end

  if isSue then
    print("Really the correct Sue is "..l:match("(Sue %d+)"))
    break
  end
end
