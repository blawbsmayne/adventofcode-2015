io.input("input.txt")

weights = {}
while true do
  local l = io.read("*line")
  if l == nil then break end
  table.insert(weights, tonumber(l))
end

weightsum = 0
for _,v in ipairs(weights) do
  weightsum = weightsum + v
end

function distribute(weight, qe, items, index, results, goal, indices, partitions)
  if index > #weights then
    if weight == goal and checkPartitions(indices, partitions) then
      if results[items] == nil then
        results[items] = qe
      else
        results[items] = math.min(qe, results[items])
      end
    end
    return
  end

  --do not add package
  distribute(weight, qe, items, index+1, results, goal, indices, partitions)

  --add package
  weight = weight + weights[index]
  table.insert(indices, index)

  if weight <= goal then
    distribute(weight, qe*weights[index], items+1, index+1, results, goal, indices, partitions)
  end

  --remove package again
  table.remove(indices, #indices)
end

--checks whether all weights not listed in indices can be partitioned into (partitions-1) partitions of equal weight
function checkPartitions(indices, partitions)
  -- TODO should be implemented to get a general solution to the problem
  return true
end

res = {}
distribute(0,1,0,1,res,weightsum/3,{},3)

for k,v in pairs(res) do
  print("Part 1: "..v)
  break
end

res = {}
distribute(0,1,0,1,res,weightsum/4,{},4)

for k,v in pairs(res) do
  print("Part 2: "..v)
  break
end
