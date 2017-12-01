ribbon = 0

File.foreach("data.txt") { |line|
  h, w, l = line.strip.split("x")
  h = h.to_i
  w = w.to_i
  l = l.to_i
  arr = [h, w, l]
  arr.delete_at(arr.index(arr.max))
  ribbon = ribbon + (h*w*l) + (arr.inject(:+) * 2)
}

puts ribbon