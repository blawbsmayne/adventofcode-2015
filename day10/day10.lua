--Script for Day 10 of adventOfCode

pIn = "1113122113"

--run n times on input str
function lookAndSay(str, n)
  local input = ""
  local out = str

  for i=1,n do
    input = out
    out = ""
    local prev = input:sub(1,1)
    local count = 1
    for j=2,input:len() do
      local curr = input:sub(j,j)
      if curr == prev then
        count = count+1
      else
        out = out .. count .. prev
        count = 1
      end
      prev = curr
    end
    out = out .. count .. prev
    print(i)
  end
  return out
end


p1 = lookAndSay(pIn, 40)
print("Part 1: "..p1:len())
print("Part 2 will take a looooong time.")
p2 = lookAndSay(p1, 10)
print("Part 2: "..p2:len())
