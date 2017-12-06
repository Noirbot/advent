input = File.read("input.txt")

input = input.strip.split("\n").map { |e| e.to_i }

index = 0
jumps = 0

while index >= 0 && index < input.length
  val = input[index]
  jumps = jumps + 1
  input[index] = val >= 3 ? input[index] - 1 : input[index] + 1
  index = index + val
  # puts index
end

puts jumps
