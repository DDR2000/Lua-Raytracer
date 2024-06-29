require("geometry")

function default_world()
  local w, s1, s2
  w = world()
  w.light = point_light(point(-10,10,-10), color(1,1,1))
  s1 = sphere()
  s1.material.color = color(0.8,1.0,0.6)
  s1.material.diffuse = 0.7
  s1.material.specular = 0.2
  s2 = sphere()
  s2.transform = scale(0.5,0.5,0.5)
  table.insert(w.objects, s1)
  table.insert(w.objects, s2)
  return w
end
