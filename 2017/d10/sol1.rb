require 'json'

lengths = []
'63,144,180,149,1,255,167,84,125,65,188,0,2,254,229,24'.each_codepoint { |c| lengths.push c }

lengths += [17, 31, 73, 47, 23]

knot = (0..255).to_a

skip = 0
rot_offset = 0

(1..64).each do |round|
  lengths.each do |off|
    knot = knot[0..(off-1)].reverse + knot[(off)..-1] unless off == 0
    knot.rotate!(off + skip)
    rot_offset += off + skip
    skip += 1
  end
end

knot.rotate!(-1 * rot_offset)

puts knot.to_json

xord = knot.each_slice(16).to_a.map do |spar|
  spar.reduce(:^)
end

puts xord.to_json

hexd = xord.map { |e| e.to_s(16).rjust(2, ?0) }

puts hexd.to_json

puts hexd.reduce(:+)