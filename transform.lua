require "matrix"

function translation(x,y,z)
  m = matrix(4,4)
  m[1][1]=1
  m[2][2]=1
  m[3][3]=1
  m[4][4]=1
  m[1][4]=x
  m[2][4]=y
  m[3][4]=z
  return m
end
