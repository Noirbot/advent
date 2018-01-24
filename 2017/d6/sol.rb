require 'json'

input = '14 0 15  12  11  11  3 5 1 6 8 4 9 1 8 4'

input = input.split.map { |e| e.to_i }

past_arrs = [input.clone]

puts past_arrs.to_json

loop do
  max = input.index(input.max)

  surplus = input[max]
  input[max] = 0

  (1..surplus).each do |offset|
    ind = (max + offset) % input.length
    input[ind] += 1  
  end

  break if past_arrs.include? input

  past_arrs.push input.clone
end

puts past_arrs.index(input)
puts past_arrs.length