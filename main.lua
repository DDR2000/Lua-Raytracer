require "geometry"
require "canvas"
require "transform"

floor = sphere()
floor.transform = scale(10,0.01, 10)
floor.material = material()
floor.material.color = color(1,0.9,0.9)
floor.material.specular = 0

left_wall = sphere()
left_wall.transform = matrix_mult(translation(0,0,5), matrix_mult(rotation_y(-math.pi/4), matrix_mult(rotation_x(math.pi/2),scale(10,0.01,10))))
left_wall.material = floor.material

right_wall = sphere()
right_wall.transform = matrix_mult(translation(0,0,5), matrix_mult(rotation_y(math.pi/4), matrix_mult(rotation_x(math.pi/2),scale(10,0.01,10))))
right_wall.material = floor.material

middle = sphere()
middle.transform = translation(-0.5, 1, 0.5)
middle.material = material()
middle.material.color = color(0.1, 1, 0.5)
middle.material.diffuse = 0.7
middle.material.specular = 0.3

right = sphere()
right.transform = matrix_mult(translation(1.5, 0.5, -0.5), scale(0.5, 0.5, 0.5))
right.material = material()
right.material.color = color(0.5, 1, 0.1)
right.material.diffuse = 0.7
right.material.specular = 0.3

left = sphere()
left.transform = matrix_mult(translation(-1.5, 0.33, -0.75), scale(0.33, 0.33, 0.33))
left.material = material()
left.material.color = color(1, 0.8, 0.1)
left.material.diffuse = 0.7
left.material.specular = 0.3

w = world()
table.insert(w.objects,floor)
table.insert(w.objects,left_wall)
table.insert(w.objects,right_wall)
table.insert(w.objects,middle)
table.insert(w.objects,right)
table.insert(w.objects,left)
w.light = point_light(point(-10,10,-10), color(1,1,1))
cam = camera(400,200,math.pi/3)
cam.transform = view_transform(point(0,1.5,-5),vector(0,1,0),point(0,1,0))

data = render(cam,w)

img = love.graphics.newImage(data)
data:encode("png", "out.png")

function love.draw()
  love.graphics.draw(img, 0, 0)
end
