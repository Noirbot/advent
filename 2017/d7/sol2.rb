input = File.read("input.txt").split("\n")

class Prog
  def initialize(name, weight, children)
    @name = name
    @weight = weight.to_i
    @children = children
  end

  def balance(tower)
    if @children.length == 0
      return @weight
    else
      c_weights = @children.map { |pro| tower[pro].balance(tower) }
      if c_weights.uniq.length > 1
        puts "Misbalanced at #{@name}.\nChildren:\t#{@children}\nWeights\t#{c_weights}"
        throw "Done"
      else
        return c_weights.sum + @weight
      end
    end
  end
end

tower = {}

input.each do |line|
  parts = line.split(/,?\s+/)
  if parts.length > 2
    tower[parts[0]] = Prog.new(parts[0], parts[1][1..-2], parts[3..-1])
  else
    tower[parts[0]] = Prog.new(parts[0], parts[1][1..-2], [])
  end
end

tower['eugwuhl'].balance(tower)