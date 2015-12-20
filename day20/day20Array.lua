-- use a large array to actually simulate elves

input = 34000000
max = 1000000
check = 2

--param: a(n empty) table of houses, number of gifts, stop after how many houses
function deliver(houses, gifts, stop)
  local elf = 1
  for i=1,max do
    for j=1, math.min(math.floor(max/elf), stop) do
      if houses[j*elf] == nil then houses[j*elf] = 0 end
      houses[j*elf] = houses[j*elf] + gifts*elf
    end
    elf = elf + 1
  end
end

function count(houses)
  for k,v in ipairs(houses) do
    if v >= input then
      return k
    end
  end
end

houses1 = {}
houses2 = {}

deliver(houses1, 10, max)
print("Part 1: "..count(houses1))
deliver(houses2, 11, 50)
print("Part 2: "..count(houses2))
