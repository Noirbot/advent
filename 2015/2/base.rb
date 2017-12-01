paper = 0

File.foreach("data.txt") { |line|
  h, w, l = line.strip.split("x")
  h = h.to_i
  w = w.to_i
  l = l.to_i
  paper = paper + 2*l*w + 2*w*h + 2*h*l + [l*w, w*h, h*l].min
}

puts paper