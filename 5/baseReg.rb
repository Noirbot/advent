nice = 0

File.foreach("data.txt") { |line|
  line.strip!
  if line =~ /.*(\w)\1+.*/i && line =~ /.*[aeiou].*[aeiou].*[aeiou].*/i && line !=~ /.*(ab|cd|pq|xy).*/i
    nice = nice + 1
  end
}

puts nice