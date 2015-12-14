io.input("input.txt")

finish = 2503
bestDeer = ""
maxDist = 0

deers = {} --for Pt. 2

while true do
  local l = io.read("*line")
  if l == nil then break end
  local deer, speed, fly, rest = l:match("(%a+).-(%d+).-(%d+).-(%d+)")

  --For Pt. 2
  local d = {}
  d.speed = tonumber(speed)
  d.name = deer
  d.fly = tonumber(fly)
  d.chunk = fly + tonumber(rest)
  d.distance = 0
  d.points = 0
  table.insert(deers, d)

  --Pt. 1 again
  local chunk = fly + rest
  local times = math.floor(finish / chunk)
  local remainder = finish % chunk

  local distance = (times * fly + math.min(fly, remainder)) * speed

  if distance > maxDist then
    maxDist = distance
    bestDeer = deer
  end
end

print("Part 1: The fastest deer is "..bestDeer.." with a total distance of "..maxDist)

--advance all deers
for i=0,finish-1 do
  local leadDist = 0
  for _,d in ipairs(deers) do
    if i % d.chunk < d.fly then
      d.distance = d.distance + d.speed
    end
    leadDist = math.max(d.distance, leadDist)
  end

  for _,d in ipairs(deers) do
    if d.distance == leadDist then d.points = d.points+1 end
  end
end

for _,d in ipairs(deers) do
  print(d.name, d.points)
end
