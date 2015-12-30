@wires = {}
@solved = {}

class String
    def is_i?
       /\A[-+]?\d+\z/ === self
    end
end

def solve(wire)
  if wire.is_i?
    puts "Found a number"
    return wire.to_i
  end

  if @solved[wire]
    puts "Solved to #{@solved[wire]}"
    return @solved[wire]
  end

  puts "#{wire} is #{@wires[wire]}"
  fun = @wires[wire].split(' ')

  value = nil
  case fun.size
    when 1
      value = solve(fun[0])
    when 2
      value = ~solve(fun[1]) & 0xFFFF
    when 3
      case fun[1]
        when 'OR'
          value = solve(fun[0]) | solve(fun[2])
        when 'AND'
          value = solve(fun[0]) & solve(fun[2])
        when 'LSHIFT'
          value = solve(fun[0]) << fun[2].to_i
        when 'RSHIFT'
          value = solve(fun[0]) >> fun[2].to_i
      end
  end

  if value != nil
    @solved[wire] = value
  else
    print "WTF"
  end

  return value
end


File.foreach("data.txt") { |line|
  pre, wire = line.split('->').map(&:strip)
  @wires[wire] = pre
}

puts solve('a')