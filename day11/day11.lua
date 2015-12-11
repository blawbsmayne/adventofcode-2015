input = "cqjxjnds"

--increments the string
function increment(str)
  local out = str
  local pos = #str
  while true do
    local overflow = false
    local val = out:byte(pos)
    if val == 122 then
      val = 97
      overflow = true
    else
      val = val + 1
    end
    out = out:sub(1,pos-1) .. string.char(val) .. out:sub(pos+1,#out)
    if overflow and pos > 1 then
      pos = pos - 1
    else
      break
    end
  end
  return out
end

--checks the three constraints
function check(str)
  --print("checking "..str)
  local prevprev = "{" -- ok, I don't like this either
  local prev = "{"
  local pairs = 0
  local pairJustClosed = false
  local sequence = false
  for i=1,#str do
    local char = str:sub(i,i)
    --check 1st constraint
    if prevprev:byte()+1 == prev:byte() and prev:byte()+1 == char:byte() then
      sequence = true
    end
    --check 2nd constraint
    if char=="i" or char=="o" or char=="l" then
      return false
    end
    --check 3rd constraint
    if char == prev and not pairJustClosed then
      pairs = pairs + 1
      pairJustClosed = true
    else
      pairJustClosed = false
    end
    prevprev = prev
    prev = char
  end
  return pairs > 1 and sequence
end

function getPassword(pw)
  while(true) do
    pw = increment(pw)
    if check(pw) then
      return pw
    end
  end
end

pw1 = getPassword(input)
print("The new password is "..pw1)
pw2 = getPassword(pw1)
print("The newer password is "..pw2)
