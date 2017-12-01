require 'set'

x, y = 0, 0
a = Array.new

File.foreach("data.txt") { |line|
  line.split("").each { |i|
    case i
    when '<'
      x = x - 1
    when '>'
      x = x + 1
    when '^'
      y = y + 1
    when 'v'
      y = y - 1
    end
    a.push([x, y])
  }
}

s = a.to_set

puts s.size