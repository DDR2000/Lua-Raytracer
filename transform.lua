require "matrix"

function translation(x,y,z)
  local m = matrix(4,4)
  m[1][1]=1
  m[2][2]=1
  m[3][3]=1
  m[4][4]=1
  m[1][4]=x
  m[2][4]=y
  m[3][4]=z
  return m
end

function scale(x,y,z)
  local m = matrix(4,4)
  m[1][1]=x
  m[2][2]=y
  m[3][3]=z
  m[4][4]=1
  return m
end

function rotation_x(theta)
  local m = matrix(4,4)
  m[1][1]=1
  m[2][2]=math.cos(theta)
  m[3][3]=math.cos(theta)
  m[2][3]=-math.sin(theta)
  m[3][2]=math.sin(theta)
  m[4][4]=1
  return m
end

function rotation_y(theta)
  local m = matrix(4,4)
  m[2][2]=1
  m[1][1]=math.cos(theta)
  m[3][3]=math.cos(theta)
  m[3][1]=-math.sin(theta)
  m[1][3]=math.sin(theta)
  m[4][4]=1
  return m
end

function rotation_z(theta)
  local m = matrix(4,4)
  m[3][3]=1
  m[1][1]=math.cos(theta)
  m[2][2]=math.cos(theta)
  m[1][2]=-math.sin(theta)
  m[2][1]=math.sin(theta)
  m[4][4]=1
  return m
end

function shear(xy,xz,yx,yz,zx,zy)
  local m = matrix(4,4)
  m[1][1]=1
  m[2][2]=1
  m[3][3]=1
  m[4][4]=1
  m[1][2]=xy
  m[1][3]=xz
  m[2][1]=yx
  m[2][3]=yz
  m[3][1]=zx
  m[3][2]=zy
  return m
end

function transform(r, mat)
  local r2=ray(r.origin, r.dir)
  r2.origin=matrix_mult(mat, r2.origin)
  r2.dir=matrix_mult(mat,r2.dir)
  return r2
end

function set_transform(o, T)
  o.transform=T
end

function view_transform(from, up, to)
  local forward, left, true_up, orientation
  forward = norm(subtract(to, from))
  left = cross(forward, up)   --I'd rather use the right vector here
  true_up = cross(left,forward)
  orientation = matrix(4,4)
  orientation[1][1]=left.x
  orientation[1][2]=left.y
  orientation[1][3]=left.z
  orientation[2][1]=true_up.x
  orientation[2][2]=true_up.y
  orientation[2][3]=true_up.z
  orientation[3][1]=-forward.x
  orientation[3][2]=-forward.y
  orientation[3][3]=-forward.z
  orientation[4][4]=1
  return matrix_mult(orientation, translation(-from.x,-from.y,-from.z))
end

function camera(hsize, vsize, field_of_view)
  local a,c,half_view,aspect
  c = {}
  c.hsize=hsize
  c.vsize=vsize
  c.field_of_view=math.pi/2
  a = matrix(4,4)
  for i=1,#a do
    for j=1,#a[1] do
      if i==j then
        a[i][j]=1
      end
    end
  end
  c.transform = a
  half_view = math.tan(c.field_of_view/2)
  aspect = c.hsize/c.vsize
  if aspect>=1 then
    c.half_width = half_view
    c.half_height = half_view/aspect
  else
    c.half_width = half_view*aspect
    c.half_height = half_view
  end
  c.pixel_size = (c.half_width*2)/c.hsize
  return c
end
