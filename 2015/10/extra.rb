input = '1113122113'
out = ''

it = 0
while it < 50
  c = input[0]
  count = 0
  input.split('').each do |char|
    if char != c
      if count > 0
        out = out + count.to_s + c
        count = 1
        c = char.clone
      else
        c = char.clone
      end
    else
      count = count + 1
    end
  end
  input = out + count.to_s + c
  out = ''

  it = it + 1
end

puts input.size