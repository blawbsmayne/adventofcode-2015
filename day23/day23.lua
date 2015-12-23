io.input("input.txt")

r = {}
instructions = {}
while true do
  local l = io.read("*line")
  if l == nil then break end

  local instr = {}
  instr.name = l:sub(1,3)
  if instr.name:sub(1,2) == "ji" then
    instr[1] = l:sub(5,5)
    instr[2] = l:sub(8, #l)
  else
    instr[1] = l:sub(5,#l)
  end
  table.insert(instructions, instr)
end

function run()
  local pc = 1
  while true do
    local instr = instructions[pc]
    if instr == nil then break end
    if instr.name == "hlf" then
      r[instr[1]] = math.floor(r[instr[1]]/2)
      pc = pc + 1
    elseif instr.name == "tpl" then
      r[instr[1]] = r[instr[1]] * 3
      pc = pc + 1
    elseif instr.name == "inc" then
      r[instr[1]] = r[instr[1]] + 1
      pc = pc + 1
    elseif instr.name == "jmp" then
      pc = pc + tonumber(instr[1])
    elseif instr.name == "jie" then
      if r[instr[1]]%2==0 then
        pc = pc + tonumber(instr[2])
      else
        pc = pc + 1
      end
    elseif instr.name == "jio" then
      if r[instr[1]]==1 then
        pc = pc + tonumber(instr[2])
      else
        pc = pc + 1
      end
    end
  end
end

r["a"] = 0
r["b"] = 0
run()
print("Part 1: "..r["b"])

r["a"] = 1
r["b"] = 0
run()
print("Part 2: "..r["b"])
