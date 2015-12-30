require 'pp'

reindeer = {}

File.foreach("data.txt") { |line|
  parts = line.strip.split(" ")

  reindeer[parts[0]] = {
    :speed => parts[3].to_i,
    :on => parts[6].to_i,
    :off => parts[-2].to_i
  }
}

progress = {}

reindeer.each do |key, value|
  progress[key] = {
    :running => true,
    :distance => 0,
    :score => 0,
    :toggleTime => value[:on]
  }
end

(1..2503).each do |tick|
  progress.each do |name, stats|
    if stats[:running]
      stats[:distance] = stats[:distance] + reindeer[name][:speed]
    end
    if tick == stats[:toggleTime]
      if stats[:running]
        stats[:toggleTime] = stats[:toggleTime] + reindeer[name][:off]
        stats[:running] = false
      else
        stats[:toggleTime] = stats[:toggleTime] + reindeer[name][:on]
        stats[:running] = true
      end
    end
  end

  max = progress.max_by{|k,v| v[:distance] }[1][:distance]
  winners = progress.select { |k, v| v[:distance] == max}
  winners.each do |name, value|
    progress[name][:score] = progress[name][:score] + 1
  end
end

pp progress