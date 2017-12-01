code = 0
mem = 0

File.foreach("data.txt") { |line|
  line.strip!
  code = code + line.size

  if line[0] == '"'
    line = line[1..-1]
  end
  if line[-1] == '"'
    line = line[0..-2]
  end

  trailing = ''
  discount = 0
  line.split("").each { |c|
    if trailing != '\\'
      trailing = c.clone
      next
    else
      case c
        when '\\', '"'
          discount = discount + 1
          trailing = ''
        when 'x'
          discount = discount + 3
          trailing = ''
      end
    end
  }

  mem = mem + line.size - discount
}

puts code
puts mem
puts code - mem