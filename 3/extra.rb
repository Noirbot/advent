require 'set'
require 'pp'

addr = [[0,0], [0, 0]]
arr = []

File.foreach("data.txt") { |line|
  line.split("").each_with_index { |i, index|
    index = index % 2
    case i
    when '<'
      addr[index][0] = addr[index][0] - 1
    when '>'
      addr[index][0] = addr[index][0] + 1
    when '^'
      addr[index][1] = addr[index][1] + 1
    when 'v'
      addr[index][1] = addr[index][1] - 1
    end

    arr.push([addr[index].clone])
  }
}

# pp arr

puts arr.to_set.size