require 'pp'

path = {
  'start' => '',
  'end' => '',
  'length' => 100000000
}

graph = {
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

  graph[parts[0]][parts[2]] = parts[4].to_i
  graph[parts[2]][parts[0]] = parts[4].to_i
}

visited = []

visited.push(path['start'])
visited.push(path['end'])

while visited.size < 8
  options = []

  graph[path['start']].each do |place, dist|
    if not visited.include? place
      options.push({'dest' => place.clone, 'dist' => dist})
    end
  end

  min1 = options.min_by {|option| option['dist']}

  graph[path['end']].each do |place, dist|
    if not visited.include? place
      options.push({'dest' => place.clone, 'dist' => dist})
    end
  end

  min2 = options.min_by {|option| option['dist']}

  if min1 == min2
    # puts min1
    # puts path['length']
    visited.push min1['dest'].clone
    path['start'] = min1['dest'].clone
    path['length'] = path['length'] + min1['dist']
  else
    visited.push min2['dest'].clone
    path['end'] = min2['dest'].clone
    path['length'] = path['length'] + min2['dist']
  end
end

puts path