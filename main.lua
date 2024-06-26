require "geometry"
require "canvas"

data = create_canvas(800, 600)
for i=0, 799 do
  for j=0, 599 do
    write_pixel(data, i,j, color(0.5, 0.5, 1.0))
  end
end
img = love.graphics.newImage(data)

function love.draw()
  love.graphics.draw(img, 0, 0)
end
