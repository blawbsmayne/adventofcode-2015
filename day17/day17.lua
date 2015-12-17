io.input("input.txt")

cont = {}
combinations = 0
limit = 150

while true do
  local l = io.read("*line")
  if l == nil then break end
  table.insert(cont, tonumber(l))
end

--for Pt. 2
min = #cont
minCombis = 0

-- recursively try all combinations
function fill(filled, index, numCont)
  local tmp = filled
  if cont[index] + filled <= limit then -- fill container if possible
    filled = filled + cont[index]
    if filled == limit then
      combinations = combinations + 1
      --Pt. 2:
      if numCont+1 < min then
        min = numCont + 1
        minCombis = 0
      end
      if min == numCont + 1 then minCombis = minCombis + 1 end
    end
    if index < #cont and filled < limit then -- try next container
      fill(filled, index+1, numCont+1)
    end
  end
  if index < #cont then
    fill(tmp, index+1, numCont) -- "empty" current container and try next
  end
end


fill(0, 1, 0)
print("Part 1: "..combinations)
print("Part 2: "..minCombis.." combinations of "..min.." containers")
