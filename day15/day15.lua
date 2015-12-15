io.input("input.txt")

ingredients = {}
topScore = 0
topScore500 = 0

while true do
  local l = io.read("*line")
  if l == nil then break end

  local ing = {}
  ing.name, ing.cap, ing.dur, ing.flav, ing.tex, ing.cal = l:match("(%a+).-(%-?%d+).-(%-?%d+).-(%-?%d+).-(%-?%d+).-(%-?%d+)")

  table.insert(ingredients, ing)
end

function distribute(dist, index)
  if index == #ingredients then
    local remainder = 0
    for i = 1,index-1 do
      remainder = remainder + dist[i]
    end
    dist[index] = 100-remainder
    score(dist)
  else
    local rem = 0
    for i=1,index-1 do
      rem = rem + dist[i]
    end
    while dist[index] <= 100-rem do
      for i=index+1,#dist do
        dist[i] = 0
      end
      distribute(dist, index+1)
      dist[index] = dist[index]+1
    end
  end
end

function score(dist)
  local totalCap = 0
  local totalDur = 0
  local totalFlav = 0
  local totalTex = 0
  local totalCal = 0
  for i=1,#dist do
    totalCap = totalCap + dist[i] * ingredients[i].cap
    totalDur = totalDur + dist[i] * ingredients[i].dur
    totalFlav = totalFlav + dist[i] * ingredients[i].flav
    totalTex = totalTex + dist[i] * ingredients[i].tex
    totalCal = totalCal + dist[i] * ingredients[i].cal
  end
  totalCap = math.max(totalCap, 0)
  totalDur = math.max(totalDur, 0)
  totalFlav = math.max(totalFlav, 0)
  totalTex = math.max(totalTex, 0)
  local score = totalCap * totalDur * totalFlav * totalTex
  if score > topScore then
    topScore = score
  end
  if totalCal == 500 and score > topScore500 then
    topScore500 = score
  end
end

distribute({1,1,1,1},1)

print("Part 1: "..topScore)

print("Part 2: "..topScore500)
