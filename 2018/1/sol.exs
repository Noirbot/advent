File.read!("input.txt")
  |> String.trim
  |> String.split("\n", trim: true)
  |> Enum.map(&String.to_integer/1)
  |> Stream.cycle()
  |> Enum.reduce_while({0, MapSet.new([0])}, fn(x, {val, seen}) -> 
      newVal = val + x

      if MapSet.member?(seen, newVal) do
        {:halt, newVal}
      else
        {:cont, {newVal, MapSet.put(seen, newVal)}}
      end
    end)
  |> IO.puts