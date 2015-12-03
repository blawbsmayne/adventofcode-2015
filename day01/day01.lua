print("Beginning Day 1")

--Read input file
io.input("input.txt")
s = io.read("*all")

--match string for ( and )
res = 0
for oc in string.gmatch(s, "%(") do res=res+1 end
for oc in string.gmatch(s, "%)") do res=res-1 end
print("The result is:",res)

--alternate version for Part Two
res = 0

for i = 1, s:len() do
  char = s:sub(i,i)
  if char == "(" then
    res = res + 1
  elseif char == ")" then
    res = res - 1
  end
  if res == -1 then
    print("Santa entered basement in step",i)
    break
  end
end

print("Ending day 1")
