nice = 0

File.foreach("data.txt") { |line|
  last = ''
  vowels = 0
  double = false
  naughty = false

  line.strip.split('').each { |i|
    if i =~ /[aeiou]/i
      vowels = vowels + 1
    end

    if last == i
      double = true
    end

    if (last + i) =~ /ab|cd|pq|xy/i
      naughty = true
      break
    end

    last = i.clone
  }
  if !naughty && vowels >= 3 && double
    nice = nice + 1
  end
}

puts nice