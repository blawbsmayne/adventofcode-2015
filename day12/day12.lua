io.input("input.txt")

s=io.read("*all")

--count all numbers in the (json) string
function countJson(str)
  local count = 0
  for number in str:gmatch("-?%d+") do
    count = count + tonumber(number)
  end
  return count
end

print("Part One: "..countJson(s))

--Part Two
-- Solve without JSON library - "quick" and dirty
-- "idea": look for  :"red"  and check if it's part of an object
-- -- if it is, determine object boundaries and remove object
-- -- repeat until fixpoint found
-- -- use counting method of part 1 afterwards

-- checks whether thing at index a is part of a JSON object by counting brackets
function isInObj(str, a)
  local sq = 0
  local cur = 0
  for i=a,1,-1 do
    local char = str:sub(i,i)
    if char == "}" then
      cur = cur + 1
    elseif char == "]" then
      sq = sq + 1
    elseif char == "[" then
      if sq == 0 then
        return false
      else
        sq = sq - 1
      end
    elseif char == "{" then
      if cur == 0 then
        return true, i
      else
        cur = cur - 1
      end
    end
  end
end

-- removes json object containing :"red" from str or returns index until which nothing could be removed
function remove(str, index)
  local a,b = str:find(":\"red\"", index)
  if a == nil or b == nil then
    return str, index
  end
  inObj, leftCur = isInObj(str, a)
  if inObj then
    local joL = leftCur
    local joR = 0
    local bracCount = 0
    for i=b, #str do
      local char = str:sub(i,i)
      if char == "}" then
        if bracCount > 0 then
          bracCount = bracCount - 1
        else
          joR = i
          break
        end
      elseif char == "{" then
        bracCount = bracCount + 1
      end
    end
    local out = str:sub(1,joL-1).."\"\""
    out = out .. str:sub(joR+1,#str)
    return out, joL
  else
    return str, b
  end
end

ind = 0
while true do
  local len = s:len()
  local oldInd = ind
  s,ind = remove(s, ind)
  if s:len() == len and oldInd == ind then
    break
  end
end

print("Part Two: "..countJson(s))
