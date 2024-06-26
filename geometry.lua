function tuple(x,y,z,w)
  t = {}
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

function add(t1,t2)
  return tuple(t1.x+t2.x, t1.y+t2.y, t1.z+t2.z, t1.w+t2.w)
end

function subtract(t1,t2)
  return tuple(t1.x-t2.x, t1.y-t2.y, t1.z-t2.z, t1.w-t2.w)
end

function negate(t)
  return tuple(-t.x, -t.y, -t.z)
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
