require 'pp'

path = {
  'start' => '',
  'end' => '',
  'length' => 0
}

@graph = {
  'Faerun' => {},
  'Norrath' => {},
  'Tristram' => {},
  'AlphaCentauri' => {},
  'Arbre' => {},
  'Snowdin' => {},
  'Tambi' => {},
  'Straylight' => {},
}

File.foreach("data.txt") { |line|
  parts = line.strip.split(" ")

  if parts[4].to_i < path['length']
    path['start'] = parts[0]
    path['end'] = parts[2]
    path['length'] = parts[4].to_i
  end

  @graph[parts[0]][parts[2]] = parts[4].to_i
  @graph[parts[2]][parts[0]] = parts[4].to_i
}


def max_child_path(node, visited)
  long = 0
  @graph[node].each do |child, dist|
    if visited.include? child
      next
    else
      newVis = visited.clone.push(child)
      len = max_child_path(child, newVis) + dist
      long = [long, len].max
    end
  end
  return long
end

max = 0
@graph.each do |node, array|
  child_len = max_child_path(node, [node])
  max = [max, child_len].max
end

puts max