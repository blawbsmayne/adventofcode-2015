io.input("input.txt")

function animate(corners)
  local newGrid = {}
  for i = 1,100 do
    newGrid[i] = {}
    for j = 1,100 do
      local neigh = grid[i-1][j-1]+grid[i-1][j]+grid[i-1][j+1]+grid[i][j-1]+grid[i][j+1]+grid[i+1][j-1]+grid[i+1][j]+grid[i+1][j+1]
      if grid[i][j] == 1 then
        if neigh == 2 or neigh == 3 then
          newGrid[i][j] = 1
        else
          newGrid[i][j] = 0
        end
      else
        if neigh == 3 then
          newGrid[i][j] = 1
        else
          newGrid[i][j] = 0
        end
      end
    end
  end

  frame(newGrid)

  --Part Two
  if corners then
    newGrid[1][1] = 1
    newGrid[1][100] = 1
    newGrid[100][1] = 1
    newGrid[100][100] = 1
  end

  grid = newGrid
end

-- make a frame of 0s
function frame(tab)
  local row = {}
  for i=0,101 do
    row[i] = 0
  end
  tab[0] = row
  tab[101] = row
  for i=1,100 do
    tab[i][0] = 0
    tab[i][101] = 0
  end
end

function countGrid()
  local count = 0
  for i=1,100 do
    for j=1,100 do
      count = count + grid[i][j]
    end
  end
  return count
end

-- END functions

grid = {}
startGrid = grid

while true do
  local l = io.read("*line")
  if l == nil then break end

  local row = {}
  for i=1,#l do
    local char = l:sub(i,i)
    if char == "#" then
      row[i] = 1
    else
      row[i] = 0
    end
  end
  table.insert(grid, row)
end
frame(grid)

for i = 1,100 do
  animate(false)
end
count = countGrid()
print("Part 1: "..count)

grid = startGrid

for i = 1,100 do
  animate(true)
end
count = countGrid()
print("Part 2: "..count)
