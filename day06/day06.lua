io.input("input.txt")

--prepare result matrix
lights = {}
brightness = {} -- Part Two
for i = 0,999 do
  lights[i]={}
  brightness[i]={}
  for j = 0,999 do
    lights[i][j]=false
    brightness[i][j]=0
  end
end

while true do
  local s = io.read("*line")
  if s == nil then
    break
  end

  --parse coordinates
  local coords={}
  local i=1
  for w in s:gmatch("%d+") do
    coords[i] = w
    i=i+1
  end

  local toggle = false
  local turnOn = false
  --parse instruction
  if s:sub(1,6) == "toggle" then
    toggle = true
  elseif s:sub(1,7) == "turn on" then
    turnOn = true
  end

  for i = coords[1],coords[3] do
    for j = coords[2],coords[4] do
      if toggle then
        lights[i][j] = not lights[i][j]
        brightness[i][j] = brightness[i][j] + 2 -- Part Two
      else
        lights[i][j] = turnOn
        -- Part Two
        if turnOn then
          brightness[i][j] = brightness[i][j] + 1
        else
          brightness[i][j] = math.max(0, brightness[i][j]-1)
        end
      end
    end
  end

end

litLights = 0
totalBrightness = 0
for i = 0,999 do
  for j = 0,999 do
    if lights[i][j] then
      litLights = litLights + 1
    end
    totalBrightness = totalBrightness + brightness[i][j]
  end
end
print(litLights.." lights are lit.")
print("Reviewing instructions leads to a total brightness of "..totalBrightness)
