sum = 0

File.foreach("data.txt") { |line|
  line.split(/[^\d-]+/).each { |i|
    sum = sum + i.to_i
  }
}

puts sum
