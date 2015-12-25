--To continue, please consult the code grid in the manual.  Enter the code at row 2981, column 3075.
val  = 20151125
row = 2981
column = 3075

diag = row + column - 1

for i = 2,diag do
  for j=1,i do
    val = val * 252533
    val = val % 33554393
    if j == column and i == diag then
      print("Result: "..val)
      break
    end
  end
end
