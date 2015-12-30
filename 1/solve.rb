floor = 0

File.foreach("data.txt") { |line|
  line.split("").each { |i|
    case i
    when '('
      floor = floor + 1
    when ')'
      floor = floor - 1
    else
      puts "WAT: '#{i}'"
    end
  }
}

puts floor
