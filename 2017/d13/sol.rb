input = File.read("input.txt").split("\n").map { |line| line.split(': ').map(&:to_i) }

delay = 0

loop do
  caught = false
  input.each do |gate|
    layer, range = gate

    if (layer + delay) % ((range * 2) - 2) == 0
      caught = true
      break
    end
  end
  break if !caught
  delay = delay + 1
end

puts delay