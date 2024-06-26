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
