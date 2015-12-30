code = 0
long = 0

File.foreach("data.txt") { |line|
  line.strip!
  code = code + line.size

  add = 2
  line.split("").each { |c|
    if c == '\\' || c == '"'
      add = add + 1
    end
  }

  long = long + line.size + add
}

puts code
puts long
puts long - code