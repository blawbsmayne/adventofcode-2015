io.input("input.txt")
s = io.read("*all")

houses = {}
x = 0
y = 0

houses[x]={}
houses[x][y] = true

diffHouses = 1

for i=1, s:len() do
  char = s:sub(i,i)
  if char == "<" then
    x = x-1
  elseif char == ">" then
    x = x+1
  elseif char == "v" then
    y = y+1
  elseif char == "^" then
    y = y-1
  else
    print("Char " .. char .. " not recognized.")
  end

  if houses[x] == nil then
    houses[x] = {}
  end

  if houses[x][y] == nil then -- first time visiting
    houses[x][y] = true
    diffHouses = diffHouses + 1
  end
end

print(diffHouses .. " houses receive " .. s:len() .. " presents.")

-- part Two
houses = {}
houses[0] = {}
houses[0][0] = true
x1=0
y1=0
x2=0
y2=0
print("[Robo-Santa initialised]")
diffHouses = 1

for i=1, s:len() do
  char = s:sub(i,i)

  -- check which santa is to work
  if i%2 == 0 then
    locX = x1
    locY = y1
  else
    locX = x2
    locY = y2
  end

  if char == "<" then
    locX = locX-1
  elseif char == ">" then
    locX = locX+1
  elseif char == "v" then
    locY = locY+1
  elseif char == "^" then
    locY = locY-1
  else
    print("Char " .. char .. " not recognized.")
  end

  if houses[locX] == nil then
    houses[locX] = {}
  end

  if houses[locX][locY] == nil then -- first time visiting
    houses[locX][locY] = true
    diffHouses = diffHouses + 1
  end

  -- write temp cahnges back
  if i%2 == 0 then
    x1 = locX
    y1 = locY
  else
    x2 = locX
    y2 = locY
  end
end

print(diffHouses .. " houses receive " .. s:len() .. " presents from both Santas.")
