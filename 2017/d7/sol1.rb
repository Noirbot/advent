input = File.read("input.txt").split("\n")

bases = []
tops = []

input.each do |line|
  parts = line.split(/,?\s+/)
  if parts.length > 2
    bases.push parts[0]
    tops = tops + parts[3..-1]
  end
end

puts bases.length
puts tops.length
puts bases - tops