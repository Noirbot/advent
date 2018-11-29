input = File.read("input.txt").split("\n")

remaining = *(0..1999)
groups = 0

while remaining.size > 0
  toAdd = [remaining[0]]
  groups = groups + 1
  while toAdd.size > 0
    newVals = input[toAdd.pop].split[2..-1].map(&:to_i)
    toAdd = toAdd + (newVals & remaining)
    remaining = remaining - newVals
  end
end

puts groups
