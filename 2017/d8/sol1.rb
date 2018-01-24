input = File.read("input.txt").split("\n")

registers = Hash.new(0)

max_val = 0

input.each do |inst|
  reg1, action, val, f, reg2, comp, comp_val = inst.split

  cond = false
  case comp
    when '<'
      cond =  registers[reg2] < comp_val.to_i
    when '<='
      cond =  registers[reg2] <= comp_val.to_i
    when '=='
      cond = registers[reg2] == comp_val.to_i
    when '!='
      cond = registers[reg2] != comp_val.to_i
    when '>='
      cond = registers[reg2] >= comp_val.to_i
    when '>'
      cond = registers[reg2] > comp_val.to_i
    else
      raise "wtf: #{inst}"
  end

  if cond
    val = val.to_i
    if action == 'dec'
      val *= -1
    end

    registers[reg1] += val
  end

  max_val = [max_val, registers.values.max || 0].max
end

puts registers.values.max
puts max_val