function color(r,g,b)
  return {red = r, green = g, blue = b}
end

function color_add(c1, c2)
  return color(c1.red+c2.red, c1.green+c2.green, c1.blue+c2.blue)
end

function color_subtract(c1, c2)
  return color(c1.red-c2.red, c1.green-c2.green, c1.blue-c2.blue)
end

function color_mult(c1, f)
  return color(c1.red*f, c1.green*f, c1.blue*f)
end

function color_product(c1, c2)
  return color(c1.red*c2.red, c1.green*c2.green, c1.blue*c2.blue)
end

function create_canvas(x,y)
  canvas = love.image.newImageData(x, y)
  return canvas
end

function write_pixel(canvas, x, y, color)
  canvas:setPixel(x,y,color.red, color.green, color.blue, 1)
end

function point_light(pos, i)
  return {position=pos, intensity=i}
end

function material()
  return {color=color(1,1,1),ambient=0.1,diffuse=0.9,specular=0.9,shininess=200}
end

function lighting(mat, light, point, eyev, normalv, in_shadow)
  local effective_color = color_product(mat.color,light.intensity)
  local lightv = norm(subtract(light.position, point))
  local ambient = color_mult(effective_color, mat.ambient)
  if in_shadow then
    return ambient
  end
  local light_dot_normal = dot(lightv,normalv)
  local diffuse, specular
  if (light_dot_normal < 0) then
    diffuse = color(0,0,0)
    specular = color(0,0,0)
  else
    diffuse = color_mult(effective_color, mat.diffuse*light_dot_normal)
    local reflectv = reflect(negate(lightv), normalv)
    local reflect_dot_eye = dot(reflectv, eyev)
    if reflect_dot_eye <= 0 then
      specular = color(0,0,0)
    else
      factor = math.pow(reflect_dot_eye, mat.shininess)
      specular = color_mult(light.intensity, mat.specular * factor)
    end
  end
  return color_add(ambient, color_add(diffuse, specular))
end

function shade_hit(w, comps)
  return lighting(comps.object.material, w.light, comps.point, comps.eyev, comps.normalv, is_shadowed(w,comps.over_point))
end

function color_at(w,r)
  local xs, h, comps
  xs = intersect_world(w,r)
  h = hit(xs)
  if h then
    comps = prepare_computations(h,r)
    return shade_hit(w, comps)
  else
    return color(0,0,0)
  end
end

function ray_for_pixel(cam,px,py)
  local xoffset,yoffset,world_x,world_y,pixel,origin,dir
  xoffset = (px+0.5)*cam.pixel_size
  yoffset = (py+0.5)*cam.pixel_size

  world_x = -cam.half_width + xoffset
  world_y = cam.half_height - yoffset

  pixel = matrix_mult(inverse(cam.transform),point(world_x, world_y, -1))
  origin = matrix_mult(inverse(cam.transform),point(0,0,0))
  dir = norm(subtract(pixel,origin))
  return ray(origin, dir)
end

function render(cam, w)
  local image, r, c
  image = create_canvas(cam.hsize, cam.vsize)
  for y=0,cam.vsize-1 do
    for x=0,cam.hsize-1 do
      r = ray_for_pixel(cam,x,y)
      c = color_at(w, r)
      write_pixel(image, x, y, c)
    end
  end
  return image
end

function is_shadowed(w,p)
  local v,dist,dir,r,xs,h
  v = subtract(w.light.position, p)
  dist = magnitude(v)
  dir = norm(v)
  r = ray(p,dir)
  xs = intersect_world(w,r)
  h = hit(xs)
  if h and h.t<dist then
    return true
  else
    return false
  end
end
