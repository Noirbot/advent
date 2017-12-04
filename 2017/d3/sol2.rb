grid = Array.new(30) { Array.new(30) }

input = 289326
ring = 0

def ring_end(count)
  return (1 + (2*count))**2
end

while input > ring_end(ring)
  ring = ring + 1
end

depth = ring_end(ring) - input

puts (ring * 2) - (depth % (ring*2))
