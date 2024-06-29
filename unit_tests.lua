require("geometry")
require("canvas")
require("matrix")
require("transform")
require("presets")

function point_test()
  local p = point(1.0,1.0,1.0)
  assert(p.x==1.0 and p.y==1.0 and p.z==1.0 and p.w==1.0, "Point test failed")
end

function vector_test()
  local v = vector(1.0,1.0,1.0)
  assert(v.x==1.0 and v.y==1.0 and v.z==1.0 and v.w==0.0, "Vector test failed")
end

function ray_test()
  local r = ray(point(1,2,3), vector(4,5,6))
  assert(r.origin.x==1 and r.origin.y==2 and r.origin.z==3 and r.dir.w==0, "Ray test failed")
end

function sphere_test()
  local s = sphere()
  local a = matrix(4,4)
  for i=1,#a do
    for j=1,#a[1] do
      if i==j then
        a[i][j]=1
      end
    end
  end
  assert(equal(s.transform, a), "Default sphere test failed")
end

function position_test()
  local r = ray(point(1,2,3), vector(1,1,1))
  local p = position(r,2)
  assert(p.x==3 and p.y==4 and p.z==5, "Position test failed")
end

function add_test()
  local p1 = point(1.0,1.0,1.0)
  local v = vector(1.0,1.0,1.0)
  local p2 = add(p1,v)
  assert(p2.x==2.0 and p2.y==2.0 and p2.z==2.0 and p2.w==1, "Add test failed")
end

function point_subtract_test()
  local p1 = point(3.0,2.0,1.0)
  local p2 = point(5.0,6.0,7.0)
  local v = subtract(p1,p2)
  assert(v.x==-2 and v.y==-4 and v.z==-6 and v.w==0, "Point subtract test failed")
end

function point_vector_subtract_test()
  local p1 = point(3.0,2.0,1.0)
  local v = vector(5.0,6.0,7.0)
  local p2 = subtract(p1,v)
  assert(p2.x==-2 and p2.y==-4 and p2.z==-6 and p2.w==1, "Point vector subtract test failed")
end

function vector_subtract_test()
  local v1 = vector(3.0,2.0,1.0)
  local v2 = vector(5.0,6.0,7.0)
  local v = subtract(v1,v2)
  assert(v.x==-2 and v.y==-4 and v.z==-6 and v.w==0, "Vector subtract test failed")
end

function magnitude_test()
  local v = vector(1.0,2.0,-3.0)
  assert(magnitude(v)==math.sqrt(14), "Magnitude test failed")
end

function normalize_test()
  local v = vector(1, 2, 3)
  assert(magnitude(norm(v))==1, "Normalize test failed")
end

function dot_test()
  local v1 = vector(1, 2, 3)
  local v2 = vector(2, 3, 4)
  assert(dot(v1,v2)==20, "Dot test failed")
end

function cross_test()
  local v1 = vector(1, 2, 3)
  local v2 = vector(2, 3, 4)
  local v3 = cross(v1, v2)
  local v4 = cross(v2, v1)
  assert(v3.x==-1, v3.y==2, v3.z==-1, "Cross test failed")
  assert(v4.x==1, v4.y==-2, v4.z==1, "Cross test failed")
end

function color_test()
  local c = color(-0.5, 0.4, 1.7)
  assert(c.red==-0.5 and c.green==0.4 and c.blue==1.7, "Color test failed")
end

function color_add_test()
  local c1 = color(0.9, 0.6, 0.75)
  local c2 = color(0.7, 0.1, 0.25)
  local c = color_add(c1, c2)
  assert(c.red==1.6 and c.green==0.7 and c.blue==1.0, "Color add test failed")
end

function color_subtract_test()
  local c1 = color(0.90, 0.6, 0.75)
  local c2 = color(0.50, 0.1, 0.25)
  local c = color_subtract(c1, c2)
  assert(c.red==0.4 and c.green==0.5 and c.blue==0.5, "Color subtract test failed")
end

function color_mult_test()
  local c1 = color(0.2, 0.3, 0.4)
  local c = color_mult(c1, 2)
  assert(c.red==0.4 and c.green==0.6 and c.blue==0.8, "Color multiplication test failed")
end

function color_product_test()
  local c1 = color(1, 0.2, 0.4)
  local c2 = color(0.9, 1, 0.1)
  local c = color_product(c1, c2)
  print(c.red)
  print(c.green)
  print(c.blue)
  assert(c.red==0.9 and c.green==0.2 and c.blue==0.04, "Color product test failed")
end

function matrix_test()
  local m = matrix(4,4)
  assert(#m==4 and #m[1]==4 and #m[2]==4 and #m[3]==4 and #m[4]==4, "Matrix test failed")
end

function matrix_equality_test()
  local a = matrix(4,4)
  local b = matrix(4,4)
  assert(equal(a,b), "Matrix equality test failed")
end

function matrix_mult_test()
  local a = matrix(4,4)
  for i=1,#a do
    for j=1,#a[1] do
      a[i][j] = i
    end
  end
  local b = matrix(4,4)
  for i=1,#a do
    for j=1,#a[1] do
      b[i][j] = j
    end
  end
  local c = matrix_mult(a,b)
  assert(c[2][2]==16 and c[3][3]==36 and c[4][4]==64 and c[2][4]==c[4][2], "Matrix multiplication test failed")
end

function matrix_tuple_mult_test()
  local a = matrix(4,4)
  for i=1,#a do
    for j=1,#a[1] do
      a[i][j] = i
    end
  end
  local b = tuple(1,2,3,1)
  local c = matrix_mult(a,b)
  assert(c.x==7 and c.y==14 and c.z==21, "Matrix tuple multiplication test failed")
end

function identity_matrix_test()
  local a = matrix(4,4)
  for i=1,#a do
    for j=1,#a[1] do
      if i==j then
        a[i][j]=1
      end
    end
  end
  local b = tuple(1,2,3,1)
  local c = matrix_mult(a,b)
  assert(c.x==1 and c.y==2 and c.z==3, "Identity matrix tuple multiplication test failed")
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
  local a = matrix(4,4)
  for i=1,#a do
    for j=1,#a[1] do
      a[i][j] = i
    end
  end
  local b = submatrix(a,1,2)
  assert(#b==3 and #b[1]==3 and b[2][1]==3, "Submatrix test failed")
end

function matrix_minor_test()
  local a = matrix(3,3)
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
  local a = matrix(3,3)
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
  local a = matrix(4,4)
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
  local a = matrix(4,4)
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
  local a = translation(5,-3,2)
  local p1 = point(-3,4,5)
  local p2 = matrix_mult(a,p1)
  assert(p2.x==2 and p2.y==1 and p2.z==7, "Translation test failed")
  local v1 = vector(3,6,-4)
  local v2 = matrix_mult(a, v1)
  assert(v2.x==v1.x and v2.y==v1.y and v2.z==v1.z, "Translation vector test failed")
end

function scale_test()
  local s = scale(-1,1,1)
  local p1 = point(2,3,4)
  local p2 = matrix_mult(s, p1)
  assert(p2.x==-2, p2.y==3, p2.z==4, "Scale test failed")
end

function transform_test()
  local p1 = point(1,0,1)
  local a = rotation_x(math.pi/2)
  local b = scale(5,5,5)
  local c = translation(10,5,7)
  local p2 = matrix_mult(a,p1)
  local p3 = matrix_mult(b,p2)
  local p4 = matrix_mult(c,p3)
  assert(p4.x==15 and p4.y==0 and p4.z==7, "Chained transform test failed")
  local T = matrix_mult(c,matrix_mult(b,a))
  local p5 = matrix_mult(T, p1)
  assert(p5.x==15 and p5.y==0 and p5.z==7, "Chained transform test failed")
end

function sphere_transform_test()
  local T = matrix_mult(translation(1,1,2), scale(2,2,2))
  local s = sphere()
  set_transform(s,T)
  assert(equal(s.transform,T), "Sphere transform test failed")
end

function intersect_test()
  local r = ray(point(0,0,-5), vector(0,0,1))
  local s = sphere()
  local xs = intersect(s,r)
  assert(#xs==2 and xs[1].object==s and xs[2].object==s and xs[1].t<xs[2].t, "Intersect test failed")
end

function intersect_tangent_test()
    local r = ray(point(0,1,-5), vector(0,0,1))
    local s = sphere()
    local xs = intersect(s,r)
    assert(#xs==2 and xs[1].t==xs[2].t and xs[2].t==5, "Intersect tangent test failed")
end

function no_intersect_test()
  local r = ray(point(0,2,-5), vector(0,0,1))
  local s = sphere()
  local xs = intersect(s,r)
  assert(#xs==0, "Zero intersect test failed")
end

function center_intersect_test()
  local r = ray(point(0,0,0), vector(0,0,1))
  local s = sphere()
  local xs = intersect(s,r)
  assert(#xs==2 and xs[1].t==-1 and xs[2].t==1, "Enclosed intersect test failed")
end

function past_intersect_test()
  local r = ray(point(0,0,5), vector(0,0,1))
  local s = sphere()
  local xs = intersect(s,r)
  assert(#xs==2 and xs[1].t==-6 and xs[2].t==-4, "Past intersect test failed")
end

function intersections_test()
  local s = sphere()
  local i1 = intersection(1,s)
  local i2 = intersection(2,s)
  local xs = intersections(i2,i1)
  assert(xs[1].t==1 and xs[2].t==2 and #xs==2, "Intersections test failed")
end

function hits_test()
  local s = sphere()
  local i1 = intersection(5,s)
  local i2 = intersection(7,s)
  local i3 = intersection(-3,s)
  local i4 = intersection(2,s)
  local i5 = intersection(6,s)
  local xs = intersections(i1,i2,i3,i4,i5)
  assert(hit(xs)==i4, "Hits test failed")
end

function ray_transform_test()
  local tm = translation(2,3,4)
  local r1 = ray(point(1,2,3), vector(0,1,0))
  local r2 = transform(r1, tm)
  assert(r2.origin.x==3 and r2.origin.y==5 and r2.origin.z==7 and equal(r1.dir, r2.dir), "Ray transform test failed")
  local sm = scale(2,2,2)
  local r3 = transform(r1, sm)
  assert(r3.origin.x==2 and r3.origin.y==4 and r3.origin.z==6, "Ray scale transform test failed")
end

function transformed_intersect_test()
  local s = sphere()
  local T = translation(5,0,0)
  set_transform(s,T)
  local r = ray(point(0,0,-5), vector(0,0,1))
  local xs = intersect(s,r)
  assert(#xs==0, "Transformed intersect test failed")
  T = scale(2,2,2)
  set_transform(s,T)
  xs = intersect(s,r)
  assert(#xs==2 and xs[1].t==3 and xs[2].t==7, "Transformed intersect test failed")
end

function normal_test()
  s = sphere()
  set_transform(s,translation(0,1,0))
  local n = normal_at(s,point(0,1.70711,-0.70711))
  assert(n.x==0 and n.y==0.70711 and n.z==-0.70711, "Normal test failed")
end

function reflect_test()
  local v = vector(0,-1,0)
  local n = vector(math.sqrt(2)/2,math.sqrt(2)/2,0)
  local r = reflect(v,n)
  assert(r.x==1 and r.y==0 and r.z==0 and r.w==0, "Normal test failed")
end

function lighting_test()
  local m = material()
  local pos = point(0,0,0)
  local eyev = vector(0,0,-1)
  local normalv = vector(0,0,-1)
  local light = point_light(point(0,0,-10),color(1,1,1))
  local result = lighting(m,light,pos,eyev,normalv)
  --assert(result.red==1.9 and result.green==1.9 and result.blue==1.9, "Lighting test 1 failed")

  eyev=vector(0,math.sqrt(2)/2,-math.sqrt(2)/2)
  result = lighting(m,light,pos,eyev,normalv)
  --assert(result.red==1.0 and result.green==1.0 and result.blue==1.0, "Lighting test 2 failed")

  eyev = vector(0,0,-1)
  normalv = vector(0,0,-1)
  light = point_light(point(0,10,-10),color(1,1,1))
  result = lighting(m,light,pos,eyev,normalv)
  --assert(result.red==0.7364 and result.green==0.7364 and result.blue==0.7364, "Lighting test 3 failed")

  eyev=vector(0,-math.sqrt(2)/2,-math.sqrt(2)/2)
  light = point_light(point(0,10,-10),color(1,1,1))
  result = lighting(m,light,pos,eyev,normalv)
  --assert(result.red==1.6364 and result.green==1.6364 and result.blue==1.6364, "Lighting test 4 failed")

  eyev = vector(0,0,-1)
  normalv = vector(0,0,-1)
  light = point_light(point(0,0,10),color(1,1,1))
  result = lighting(m,light,pos,eyev,normalv)
  assert(result.red==0.1 and result.green==0.1 and result.blue==0.1, "Lighting test 5 failed")
end

function ray_world_test()
  local w,r,xs
  w = default_world()
  r = ray(point(0,0,-5), vector(0,0,1))
  xs = intersect_world(w,r)
  assert(#xs==4 and xs[1].t==4 and xs[2].t==4.5 and xs[3].t==5.5 and xs[4].t==6, "Ray-World intersection test failed")
end

function precomputation_test()
  local r,s,xs,comps
  r = ray(point(0,0,-5), vector(0,0,1))
  s = sphere()
  i = intersection(4,s)
  comps = prepare_computations(i,r)
  assert(comps.inside==false and comps.t==i.t and comps.object==i.object and comps.point.x==0 and comps.point.y==0 and comps.point.z==-1 and comps.eyev.x==0 and comps.eyev.y==0 and comps.eyev.z==-1 and comps.normalv.x==0 and comps.normalv.y==0 and comps.normalv.z==-1, "Precomputations test 1 failed")
  r = ray(point(0,0,0), vector(0,0,1))
  i= intersection(1,s)
  comps = prepare_computations(i,r)
  assert(comps.inside==true and comps.t==i.t and comps.object==i.object and comps.point.x==0 and comps.point.y==0 and comps.point.z==1 and comps.eyev.x==0 and comps.eyev.y==0 and comps.eyev.z==-1 and comps.normalv.x==0 and comps.normalv.y==0 and comps.normalv.z==-1, "Precomputations test 2 failed")
end

function shade_hit_test()
  local w,r,s,i,comps,c
  w = default_world()
  r = ray(point(0,0,-5),vector(0,0,1))
  s = w.objects[1]
  i = intersection(4,s)
  comps = prepare_computations(i,r)
  c = shade_hit(w,comps)
  print(c.red, c.green, c.blue)
  assert(c.red==0.38066 and c.green==0.47583 and c.blue==0.2855, "Shade hit test failed")
end

function color_hit_test()
  local w,r,s,i,comps,c
  w = default_world()
  r = ray(point(0,0,0.75),vector(0,0,-1))
  s1 = w.objects[1]
  s1.material.ambient=1
  s2 = w.objects[2]
  s2.material.ambient=1
  c = color_at(w,r)
  assert(c.red==s2.material.color.red and c.blue==s2.material.color.blue, "Shade hit test failed")
end

function view_transform_test()
  local from, up, to, t
  from = point(1,3,2)
  to = point(4,-2,8)
  up = point(1,1,0)
  t = view_transform(from, up, to)
  print(t[3][3])
  assert(t[3][2]==0.59761, "View transform test failed")
end

--Geometry
point_test()
vector_test()
ray_test()
sphere_test()
position_test()
add_test()
point_subtract_test()
point_vector_subtract_test()
vector_subtract_test()
magnitude_test()
normalize_test()
dot_test()
cross_test()
--Colors
color_test()
color_add_test()
color_subtract_test()
color_mult_test()
--color_product_test()
--Matrices
matrix_test()
matrix_equality_test()
matrix_mult_test()
matrix_tuple_mult_test()
identity_matrix_test()
submatrix_test()
matrix_minor_test()
cofactor_test()
determinant_test()
--inverse_test()
--Transformations
translation_test()
scale_test()
transform_test()
--Ray Intersection
intersect_test()
intersect_tangent_test()
no_intersect_test()
center_intersect_test()
past_intersect_test()
intersections_test()
hits_test()
ray_transform_test()
sphere_transform_test()
transformed_intersect_test()
--Lighting
--normal_test()
--reflect_test()
lighting_test()
ray_world_test()

--World
precomputation_test()
--shade_hit_test()
color_hit_test()
view_transform_test()
