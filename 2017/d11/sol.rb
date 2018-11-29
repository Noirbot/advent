input = File.read('input.txt').split(',')

x = 0
y = 0
z = 0
max = 0

input.each do |move|
  case move
  when 'n'
    y = y + 1
    z = z - 1
  when 'ne'
    x = x + 1
    z = z - 1
  when 'nw'
    x = x - 1
    y = y + 1
  when 's'
    y = y - 1
    z = z + 1
  when 'se'
    x = x + 1
    y = y - 1
  when 'sw'
    x = x - 1
    z = z + 1
  else
    raise "wtf: #{move}"
  end

  max = [max, ([x.abs, y.abs, z.abs].max)].max
end

puts max
puts [x.abs, y.abs, z.abs].max