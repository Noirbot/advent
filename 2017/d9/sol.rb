input = File.read("input.txt")

score = 0
group_level = 0
in_garbage = false
neg = false

input.each_char do |cha|
  if in_garbage
    if neg
      neg = false
      next
    end

    case cha
      when '!'
        neg = true
      when '>'
        in_garbage = false
    end
  else
    case cha
      when '{'
        group_level += 1
      when '<'
        in_garbage = true
      when '}'
        score += group_level
        group_level -= 1
    end
  end 
end

puts score