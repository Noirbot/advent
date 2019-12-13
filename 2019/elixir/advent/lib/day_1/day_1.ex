defmodule Day1 do
  def part_one() do
    read_file()
      |> Enum.map(&get_fuel/1)
      |> Enum.sum
  end


  def part_two() do
    read_file()
      |> Enum.map(&get_total_fuel/1)
      |> Enum.sum
  end

  defp get_fuel(mass) do
    trunc(mass / 3) - 2
  end

  defp get_total_fuel(mass) do
    fuel = get_fuel(mass)
    if fuel <= 0 do
      0
    else
      fuel + get_total_fuel(fuel)
    end
  end

  defp read_file do
    Path.expand("./lib/day_1/input.txt")
      |> File.read!()
      |> String.trim
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
  end
end
