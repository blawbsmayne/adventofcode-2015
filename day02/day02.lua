--read input
io.input("input.txt")
--s = io.read("*all")

wrapping = 0 --the result
ribbon = 0 --the result pt. 2

while true do
  l = io.read("*line")
  if l == nil then break end -- end of file
  nums = {}
  sides = {}
  for num in l:gmatch("%d+") do
    table.insert(nums, tonumber(num))
  end
  table.sort(nums, function(a,b) return a<b end)
  wrapping = wrapping + 2 * (nums[1]*nums[2]+nums[1]*nums[3]+nums[3]*nums[2]) + nums[1]*nums[2]

  ribbon = ribbon + 2*(nums[1]+nums[2]) + nums[1]*nums[2]*nums[3]
end

print("The elves need",wrapping,"sqft. of wrapping paper.")
print("The elves need",ribbon,"ft. of ribbon.")
