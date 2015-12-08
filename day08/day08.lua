io.input("input.txt")

length = 0
inMemLen = 0
newAdd = 0

while true do
  l = io.read("*line")
  if l == nil then
    break
  end

  local escaped = false
  local lineLength = 0

  local escX = false
  local escXCnt = 0

  newAdd=newAdd+4 --Pt2: add 2 for each surrounding "

  for i=2, l:len()-1 do --ignore surrounding ""
    local char = l:sub(i,i)

    if not escaped and not escX then
      lineLength = lineLength+1
      if char == "\\" then
        escaped = true
        newAdd = newAdd+1 --Pt2: escape the escape character
      end
    else if escaped then
      if char == "x" then
        escX=true
        escXCnt = 2
      else
        newAdd=newAdd+1 --Pt2: escaped \ or "
      end
      escaped = false
    else
      if escXCnt > 1 then
        escXCnt = escXCnt-1
      else
        escX = false
      end
    end
    end
  end
  length = length + l:len()
  inMemLen = inMemLen + lineLength
end

print(length.." vs. "..inMemLen.." => "..(length-inMemLen))
print("Part 2: "..newAdd) -- alternatively: count \ and " and add 2 per line to count
