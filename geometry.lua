function tuple(x,y,z,w)
  local t = {}
  t.x = x
  t.y = y
  t.z = z
  t.w = w
  return t
end

function point(x,y,z)
  return tuple(x,y,z,1)
end

function vector(x,y,z)
  return tuple(x,y,z,0)
end

function ray(p, v)
  local r = {}
  r.origin = p
  r.dir = v
  return r
end

function sphere()
  local mat = matrix(4,4)
  mat[1][1]=1
  mat[2][2]=1
  mat[3][3]=1
  mat[4][4]=1
  return {center=point(0,0,0), transform=mat, material=material()}
end

function world()
  return {objects={}, light=nil}
end

function intersection(vt, s)
  return {type = "intersection",t = vt, object=s}
end

function intersections(...)
  local ints = {}
  for i=1,select("#",...)do
    ints[i]=select(i,...)
  end
  table.sort(ints, function(a,b)
    return a.t<b.t
  end
  )
  return ints
end

function position(r,t)
  return add(r.origin,mult(r.dir,t))
end

function add(t1,t2)
  return tuple(t1.x+t2.x, t1.y+t2.y, t1.z+t2.z, t1.w+t2.w)
end

function subtract(t1,t2)
  return tuple(t1.x-t2.x, t1.y-t2.y, t1.z-t2.z, t1.w-t2.w)
end

function negate(t)
  return tuple(-1*t.x, -1*t.y, -1*t.z, t.w)
end

function mult(v,f)
  return tuple(v.x*f, v.y*f, v.z*f, v.w*f)
end

function magnitude(v)
  assert(v.w==0, "Argument is not a vector")
  return math.sqrt(v.x^2 + v.y^2 + v.z^2 +v.w^2)
end

function norm(v)
  assert(v.w==0, "Argument is not a vector")
  return tuple(v.x/magnitude(v), v.y/magnitude(v), v.z/magnitude(v), v.w/magnitude(v))
end

function dot(a,b)
  return (a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w)
end

function cross(a,b)
  return vector(a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x)
end

function intersect(s, r)
  local r2 = transform(r, inverse(s.transform))
  local center = s.center
  local sphere_to_ray = subtract(r2.origin,center)
  local a = dot(r2.dir, r2.dir)
  local b = dot(r2.dir, sphere_to_ray)*2
  local c = dot(sphere_to_ray, sphere_to_ray)-1
  disc = b^2 - 4*a*c
  if disc < 0 then
    return nil
  end
  local t1 = (-b - math.sqrt(disc))/(2*a)
  local t2 = (-b + math.sqrt(disc))/(2*a)
  local x1 = intersection(t1,s)
  local x2 = intersection(t2,s)
  return intersections(x1, x2)
end

function hit(ints)
  if ints==nil then
    return nil
  end
  for i=1,#ints do
    if ints[i].t>0 then
      return ints[i]
    end
  end
  return nil
end

function normal_at(s, worldp)
  local objectp = matrix_mult(inverse(s.transform), worldp)
  local objectn = subtract(objectp,point(0,0,0))
  local worldn = matrix_mult(transpose(inverse(s.transform)), objectn)
  worldn.w=0
  return norm(worldn)
end

function reflect(v,n)
  return subtract(v, mult(n,2*dot(v,n)))
end

function intersect_world(world, r)
  local xs = {}
  local flatxs = {}
  for i=1,#world.objects do
    local o = world.objects[i]
    local x = intersect(o,r)
    if x ~= nil then
      table.insert(xs,x)
    end
  end
  for _,it in pairs(xs) do
    for _,tab in pairs(it) do
      table.insert(flatxs, tab)
    end
  end
  table.sort(flatxs, function(a,b)
    return a.t<b.t
  end
  )
  return flatxs
end

function prepare_computations(x, r)
  local comps = {}
  comps.inside = nil
  comps.t = x.t
  comps.object = x.object
  comps.point = position(r, comps.t)
  comps.eyev = negate(r.dir)
  comps.normalv = normal_at(comps.object, comps.point)
  if dot(comps.normalv, comps.eyev)<0 then
    comps.inside=true
    comps.normalv=negate(comps.normalv)
  else
    comps.inside=false
  end
  comps.over_point = add(comps.point, mult(comps.normalv,0.00001))
  return comps
end
