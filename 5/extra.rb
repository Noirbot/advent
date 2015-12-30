nice = 0

File.foreach("data.txt") { |line|
  if line =~ /.*(\w{2}).*\1{1}.*/i && line =~ /.*(\w{1}).{1}\1{1}.*/i
    nice = nice + 1
  end
}

puts nice