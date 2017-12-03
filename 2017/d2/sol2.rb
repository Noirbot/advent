input = File.read("input.txt")

input = input.split("\n")

total = 0

def find_div (arr)
  # puts arr
  arr.each_with_index do |num, i|
    arr[(i + 1)..-1].each do |num2|
      if (num % num2 == 0)
        return num/num2
      end
    end
  end

  raise "Fuck me"
end

input.each do |line|
  numbers = line.split.map{ |e| e.to_i }.sort.reverse
  total = total + find_div(numbers)
end

puts total
