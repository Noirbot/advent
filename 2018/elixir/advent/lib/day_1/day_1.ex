defmodule Day1 do
  def part_one, do: Enum.sum(read_file())

  def part_two() do
    read_file()
      |> Stream.cycle()
      |> Enum.reduce_while({0, MapSet.new([0])}, fn(x, {val, seen}) -> 
          newVal = val + x

          if MapSet.member?(seen, newVal) do
            {:halt, newVal}
          else
            {:cont, {newVal, MapSet.put(seen, newVal)}}
          end
        end)
  end

  defp read_file do
    Path.expand("./lib/day_1/input.txt")
      |> File.read!()
      |> String.trim
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
  end
end