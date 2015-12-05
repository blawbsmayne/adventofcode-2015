io.input("input.txt")

nice=0
nicer=0 -- Pt. 2
tVowel = {["a"]=true, ["e"]=true, ["i"]=true, ["o"]=true, ["u"]=true}
tException = {["ab"]=true, ["cd"]=true, ["pq"]=true, ["xy"]=true}

while true do
  local s=io.read("*line")
  if s == nil then
    break
  end

  local vowels = 0
  local doubles = false
  local exceptions = false

  local prevChar = ""

  for i=1,s:len() do
    char = s:sub(i,i)

    if tVowel[char] ~= nil then
      vowels = vowels + 1
    end

    if char == prevChar then
      doubles = true
    end

    if tException[prevChar..char]~=nil then
      exceptions = true
      break
    end

    prevChar = char
  end

  if vowels >= 3 and doubles and not exceptions then
    print("The word "..s.." is nice.")
    nice = nice + 1
  end

  --Part Two
  local pairs = false
  local repeats = false
  for i=1, s:len()-2 do
    if not repeats and s:sub(i,i) == s:sub(i+2,i+2) then
      repeats = true
    end
    local pair = s:sub(i,i+1)
    if(not pairs and s:sub(i+2):find(pair) ~= nil) then
      pairs = true
    end
    if repeats and pairs then
      print("The word "..s.." is nicer.")
      nicer = nicer + 1
      break
    end
  end
end

print("Found "..nice.." nice words.")
print("Found "..nicer.." nicer words.")
