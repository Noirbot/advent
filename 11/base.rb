pass = 'hxbxwxba'

def increment(pass)
  (1..8).each do |i|
    if pass[-i] != 'z'
      pass[-i] = pass[-i].next
      return pass
    else
      pass[-i] = 'a'
      next
    end
  end
end

def is_valid(pass)
  if (pass =~ /.*(\w)\1+.*(\w)\2+.*/) && !(pass =~ /[iol]/i)
    (2..7).each do |i|
      if pass[i-2].next.next == pass[i-1].next && pass[i-1].next  == pass[i]
        return true
      end
    end
    return false
  end
end

until is_valid(pass)
  pass = increment(pass)
end

pass = increment(pass)

until is_valid(pass)
  pass = increment(pass)
end

puts pass
