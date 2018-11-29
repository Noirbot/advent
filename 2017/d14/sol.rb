require 'json'
def hash_string(input)
  lengths = []
  input.each_codepoint { |c| lengths.push c }

  lengths += [17, 31, 73, 47, 23]

  knot = (0..255).to_a

  skip = 0
  rot_offset = 0

  (1..64).each do |round|
    lengths.each do |off|
      knot = knot[0..(off-1)].reverse + knot[(off)..-1] unless off == 0
      knot.rotate!(off + skip)
      rot_offset += off + skip
      skip += 1
    end
  end

  knot.rotate!(-1 * rot_offset)

  # puts knot.to_json

  xord = knot.each_slice(16).to_a.map do |spar|
    spar.reduce(:^)
  end

  # puts xord.to_json

  hexd = xord.map { |e| e.to_s(16).rjust(2, ?0) }

  # puts hexd.to_json

  return hexd.reduce(:+)
end

@grid = []
used = 0

(0..127).each do |suff|
  row = hash_string("wenycdww-#{suff}").split('').map { |digit| digit.to_i(16).to_s(2).rjust(4, ?0) }.reduce(:+)
  # puts row
  @grid[suff] = row
  used = used + row.count('1')
end

puts used

@grid.map! { |line| line.split('').map(&:to_i) }

def clear_group(x, y)
  return unless @grid[x][y] == 1
  @grid[x][y] = @groups.to_s
  clear_group(x + 1, y) unless x + 1 > 127
  clear_group(x - 1, y) unless x - 1 < 0
  clear_group(x, y + 1) unless y + 1 > 127
  clear_group(x, y - 1) unless y - 1 < 0
end

@groups = 0
@grid.each_with_index do |x, x_index|
  x.each_with_index do |y, y_index|
    next unless y == 1
    @groups = @groups + 1
    clear_group(x_index, y_index)
  end
end

puts @groups

@grid.each do |line|
  puts line.map(&:to_s).map { |num| num.ljust(4) }.join(' ')
end