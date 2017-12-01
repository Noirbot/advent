input = File.read("input.txt")

input = input.strip.split('')

offset = input.length / 2

total = 0

input.each_with_index do |chr, i|
  if chr == input[(i + offset) % input.length]
    total = total + chr.to_i
  end
end

puts total
