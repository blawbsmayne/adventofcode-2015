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

-- data
distances = {}
places = {}
names = {}

--parse file into distance matrix
while true do
  local l = io.read("*line")
  if l == nil then
    break
  end

  local a,b=l:find("%d+")
  local dist=l:sub(a,b)

  a,b=l:find("%a+")
  local firstPlace = l:sub(a,b)
  a,b=l:find("%a+", b+4)
  local secPlace = l:sub(a,b)

  if distances[firstPlace] == nil then
    distances[firstPlace] = {}
  end
  if distances[secPlace] == nil then
    distances[secPlace] = {}
  end

  distances[firstPlace][secPlace]=tonumber(dist)
  distances[secPlace][firstPlace]=tonumber(dist)

  --emulate set
  places[firstPlace]=true
  places[secPlace]=true
end

--move keys to values
for k,_ in pairs(places) do
  table.insert(names, k)
end

--solve problem
for route in perm(names) do
  local routeLen = 0
  for m=1, #route-1 do
    routeLen = routeLen + distances[route[m]][route[m+1]]
  end
  if minRoute == nil then
    minRoute = routeLen
    maxRoute = routeLen
  else
    minRoute = math.min(minRoute, routeLen)
    maxRoute = math.max(maxRoute, routeLen)
  end
end
print("Shortest Route is "..minRoute)
print("Longest Route is "..maxRoute)
