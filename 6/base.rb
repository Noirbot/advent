grid = Array.new(1000) { Array.new(1000, 0) }


File.foreach("data.txt") { |line|
  words = line.strip.split(' ')
  if words.size == 4
    sX, sY = words[1].split(',').map(&:to_i)
    eX, eY = words[3].split(',').map(&:to_i)
    (sX..eX).each do |x|
      (sY..eY).each do |y|
        grid[x][y] = (if grid[x][y] == 1 then 0 else 1 end)
      end
    end
  else
    sX, sY = words[2].split(',').map(&:to_i)
    eX, eY = words[4].split(',').map(&:to_i)
    (sX..eX).each do |x|
      (sY..eY).each do |y|
        if words[1] == 'on'
          grid[x][y] = 1
        else
          grid[x][y] = 0
        end
      end
    end
  end
}

on = 0
grid.map {|row| on = on + row.reduce(:+)}
puts on