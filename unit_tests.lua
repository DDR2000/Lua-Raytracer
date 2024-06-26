require("geometry")
require("canvas")
require("matrix")
require("transform")

function point_test()
  p = point(1.0,1.0,1.0)
  assert(p.x==1.0 and p.y==1.0 and p.z==1.0 and p.w==1.0, "Point test failed")
end

function vector_test()
  v = vector(1.0,1.0,1.0)
  assert(v.x==1.0 and v.y==1.0 and v.z==1.0 and v.w==0.0, "Vector test failed")
end

function add_test()
  p1 = point(1.0,1.0,1.0)
  v = vector(1.0,1.0,1.0)
  p2 = add(p1,v)
  assert(p2.x==2.0 and p2.y==2.0 and p2.z==2.0 and p2.w==1, "Add test failed")
end

function point_subtract_test()
  p1 = point(3.0,2.0,1.0)
  p2 = point(5.0,6.0,7.0)
  v = subtract(p1,p2)
  assert(v.x==-2 and v.y==-4 and v.z==-6 and v.w==0, "Point subtract test failed")
end

function point_vector_subtract_test()
  p1 = point(3.0,2.0,1.0)
  v = vector(5.0,6.0,7.0)
  p2 = subtract(p1,v)
  assert(p2.x==-2 and p2.y==-4 and p2.z==-6 and p2.w==1, "Point vector subtract test failed")
end

function vector_subtract_test()
  v1 = vector(3.0,2.0,1.0)
  v2 = vector(5.0,6.0,7.0)
  v = subtract(v1,v2)
  assert(v.x==-2 and v.y==-4 and v.z==-6 and v.w==0, "Vector subtract test failed")
end

function magnitude_test()
  v = vector(1.0,2.0,-3.0)
  assert(magnitude(v)==math.sqrt(14), "Magnitude test failed")
end

function normalize_test()
  v = vector(1, 2, 3)
  assert(magnitude(norm(v))==1, "Normalize test failed")
end

function dot_test()
  v1 = vector(1, 2, 3)
  v2 = vector(2, 3, 4)
  assert(dot(v1,v2)==20, "Dot test failed")
end

function cross_test()
  v1 = vector(1, 2, 3)
  v2 = vector(2, 3, 4)
  v3 = cross(v1, v2)
  v4 = cross(v2, v1)
  assert(v3.x==-1, v3.y==2, v3.z==-1, "Cross test failed")
  assert(v4.x==1, v4.y==-2, v4.z==1, "Cross test failed")
end

function color_test()
  c = color(-0.5, 0.4, 1.7)
  assert(c.red==-0.5 and c.green==0.4 and c.blue==1.7, "Color test failed")
end

function color_add_test()
  c1 = color(0.9, 0.6, 0.75)
  c2 = color(0.7, 0.1, 0.25)
  c = color_add(c1, c2)
  assert(c.red==1.6 and c.green==0.7 and c.blue==1.0, "Color add test failed")
end

function color_subtract_test()
  c1 = color(0.90, 0.6, 0.75)
  c2 = color(0.50, 0.1, 0.25)
  c = color_subtract(c1, c2)
  assert(c.red==0.4 and c.green==0.5 and c.blue==0.5, "Color subtract test failed")
end

function color_mult_test()
  c1 = color(0.2, 0.3, 0.4)
  c = color_mult(c1, 2)
  assert(c.red==0.4 and c.green==0.6 and c.blue==0.8, "Color multiplication test failed")
end

function color_product_test()
  c1 = color(1, 0.2, 0.4)
  c2 = color(0.9, 1, 0.1)
  c = color_product(c1, c2)
  print(c.red)
  print(c.green)
  print(c.blue)
  assert(c.red==0.9 and c.green==0.2 and c.blue==0.04, "Color product test failed")
end

function matrix_test()
  m = matrix(4,4)
  assert(#m==4 and #m[1]==4 and #m[2]==4 and #m[3]==4 and #m[4]==4, "Matrix test failed")
end

function matrix_equality_test()
  a = matrix(4,4)
  b = matrix(4,4)
  assert(equal(a,b), "Matrix equality test failed")
end

function matrix_mult_test()
  a = matrix(4,4)
  for i=1,#a do
    for j=1,#a[1] do
      a[i][j] = i
    end
  end
  b = matrix(4,4)
  for i=1,#a do
    for j=1,#a[1] do
      b[i][j] = j
    end
  end
  c = matrix_mult(a,b)
  assert(c[2][2]==16 and c[3][3]==36 and c[4][4]==64 and c[2][4]==c[4][2], "Matrix multiplication test failed")
end

function matrix_tuple_mult_test()
  a = matrix(4,4)
  for i=1,#a do
    for j=1,#a[1] do
      a[i][j] = i
    end
  end
  b = tuple(1,2,3,1)
  c = matrix_mult(a,b)
  assert(#c==4 and #c[1]==1 and c[3][1]==21, "Matrix tuple multiplication test failed")
end

function identity_matrix_test()
  a = matrix(4,4)
  for i=1,#a do
    for j=1,#a[1] do
      if i==j then
        a[i][j]=1
      end
    end
  end
  b = tuple(1,2,3,1)
  c = matrix_mult(a,b)
  assert(c[1][1]==1 and c[2][1]==2 and c[3][1]==3, "Identity matrix tuple multiplication test failed")
  b = matrix(4,4)
  for i=1,#a do
    for j=1,#a[1] do
      b[i][j] = j
    end
  end
  c = matrix_mult(b,a)
  assert(c[1][1]==1 and c[1][2]==2 and c[1][3]==3, "Identity matrix multiplication test failed")
end

function submatrix_test()
  a = matrix(4,4)
  for i=1,#a do
    for j=1,#a[1] do
      a[i][j] = i
    end
  end
  b = submatrix(a,1,2)
  assert(#b==3 and #b[1]==3 and b[2][1]==3, "Submatrix test failed")
end

function matrix_minor_test()
  a = matrix(3,3)
  a[1][1] = 3
  a[1][2] = 5
  a[1][3] = 0
  a[2][1] = 2
  a[2][2] = -1
  a[2][3] = -7
  a[3][1] = 6
  a[3][2] = -1
  a[3][3] = 5
  b = submatrix(a, 2, 1)
  detm = minor(a, 2, 1)
  assert(det(b)==detm, "Matrix minor test failed")
end

function cofactor_test()
  a = matrix(3,3)
  a[1][1] = 3
  a[1][2] = 5
  a[1][3] = 0
  a[2][1] = 2
  a[2][2] = -1
  a[2][3] = -7
  a[3][1] = 6
  a[3][2] = -1
  a[3][3] = 5
  assert(minor(a,1,1)==-12 and cofactor(a,1,1)==-12 and minor(a,2,1)==25 and cofactor(a,2,1)==-25, "Cofactor test failed")
end

function determinant_test()
  a = matrix(4,4)
  a[1][1] = -2
  a[1][2] = -8
  a[1][3] = 3
  a[1][4] = 5
  a[2][1] = -3
  a[2][2] = 1
  a[2][3] = 7
  a[2][4] = 3
  a[3][1] = 1
  a[3][2] = 2
  a[3][3] = -9
  a[3][4] = 6
  a[4][1] = -6
  a[4][2] = 7
  a[4][3] = 7
  a[4][4] = -9
  assert(det(a)==-4071, "Determinant test failed")
end

function inverse_test()
  a = matrix(4,4)
  a[1][1] = 8
  a[1][2] = -5
  a[1][3] = 9
  a[1][4] = 2
  a[2][1] = 7
  a[2][2] = 5
  a[2][3] = 6
  a[2][4] = 1
  a[3][1] = -6
  a[3][2] = 0
  a[3][3] = 9
  a[3][4] = 6
  a[4][1] = -3
  a[4][2] = 0
  a[4][3] = -9
  a[4][4] = -4
  print(inverse(a)[1][2])
  assert(inverse(a)[1][2]==-0.15385, "Inverse test failed")
end

function translation_test()
  a = translation(5,-3,2)
  p1 = point(-3,4,5)
  p2 = matrix_mult(a,p1)
  assert(p2.x==2 and p2.y==1 and p2.z==7, "Translation test failed")
end
--[[
point_test()
vector_test()
add_test()
point_subtract_test()
point_vector_subtract_test()
vector_subtract_test()
magnitude_test()
normalize_test()
dot_test()
cross_test()
color_test()
color_add_test()
color_subtract_test()
color_mult_test()
--color_product_test()
matrix_test()
matrix_equality_test()
--matrix_mult_test()
--matrix_tuple_mult_test()
--identity_matrix_test()
submatrix_test()
matrix_minor_test()
cofactor_test()
determinant_test()
--inverse_test()
--]]
translation_test()
