floor = 0

File.foreach("data.txt") { |line|
  line.split("").each_with_index { |i, index|
    case i
    when '('
      floor = floor + 1
    when ')'
      floor = floor - 1
    end
    if floor == -1
      puts index
      abort("Done")
    end
  }
}

puts floor