input = File.read("input.txt")

puts input

input = input.strip.split('')

total = 0

input.each_with_index do |chr, i|
  if chr == input[i-1]
    total = total + chr.to_i
  end
end

puts total
