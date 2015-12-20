-- naive approach with less memory - should work, takes ages

input = 34000000

check = 3

while true do
  local divs = {}
  for i=1, math.floor(check/2) do
    if math.fmod(check, i) == 0 then
      table.insert(divs, i)
    end
  end
  table.insert(divs, check)

  local count = 0
  for _,v in pairs(divs) do
    count = count + v
  end

  if 10*count >= input then
    print("Part 1: "..check)
    break
  end

  check = check + 1
  if check % 100 == 0 then print(check, 10*count) end -- TODO
end
