function matrix(n,m)
  mt = {}
  for i=1,n do
    mt[i]={}
    for j=1,m do
      mt[i][j] = 0
    end
  end
  return mt
end

function equal(a,b)
  for i=1,#a do
    for j=1,#a[1] do
      if a[i][j] ~= b[i][j] then
        return false
      end
    end
  end
  return true
end

function invertible(mat)
  return det(mat)~=0
end

function matrix_mult(a,b)
  if b.w ~= nil then
    p = matrix(4,1)
    for i=1,#a do
      p[i][1]=(a[i][1] * b.x) + (a[i][2] * b.y) + (a[i][3] * b.z) + (a[i][4] * b.w)
    end
    return tuple(p[1][1], p[2][1], p[3][1], p[4][1])
  end
  c = matrix(#a, #b[1])
  for i=1,#c do
    for j=1,#c[1] do
      c[i][j] = (a[i][1] * b[1][j]) + (a[i][2] * b[2][j]) + (a[i][3] * b[3][j]) + (a[i][4] * b[4][j])
    end
  end
  return c
end

function det(mat)
  if(#mat==2 and #mat[1]==2) then
    return (mat[1][1]*mat[2][2]) - (mat[1][2]*mat[2][1])
  end
  detm = 0
  for c=1,#mat[1] do
    detm = detm + mat[1][c]*cofactor(mat, 1, c)
  end
  return detm
end

function transpose(a)
  b = matrix(#a, #a[0])
  for i=1,#a do
    for j=1,#a[0] do
      b[i][j] = a[j][i]
    end
  end
  return b
end

function submatrix(a, r, c)
  mat = matrix(#a, #a[1])
  for i=1,#a do
    for j=1,#a[1] do
      mat[i][j] = a[i][j]
    end
  end
  table.remove(mat, r)
  for i=1,#mat do
    table.remove(mat[i], c)
  end
  return mat
end

function minor(mat, x, y)
  submat = submatrix(mat, x, y)
  return det(submat)
end

function cofactor(mat, x, y)
  if (x+y)%2==0 then
    return minor(mat, x, y)
  end
  return -minor(mat, x, y)
end

function inverse(mat)
  assert(invertible(mat), "Matrix is not invertible")
  mat2 = matrix(#mat, #mat[1])

  for i=1,#mat do
    for j=1,#mat[1] do
      c = cofactor(mat, i, j)
      mat2[j][i] = c/det(mat)
    end
  end
  return mat2
end
