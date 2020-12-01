defmodule Day1 do
  def part_one() do
    read_file()
      |> find_pair
      |> Enum.reduce(&*/2)
  end

  defp find_pair(list, target \\ 2020) do
    val = list
      |> Enum.find(fn x -> Enum.member?(list, target - x) end)

    case val do
      nil -> false
      _ -> [val, target - val]
    end
  end

  def part_two() do
    read_file()
      |> Enum.map(fn x -> {x, 2020 - x} end)
      |> find_triple
  end

  defp find_triple(list) do
    {values, targets} = Enum.unzip(list)

    targets
      |> Enum.find(fn x -> find_pair(values, x) end)
      |> (
        fn x -> (2020 - x) * (
          find_pair(values, x)
            |> Enum.reduce(&*/2)
          )
        end).()

  end

  defp read_file do
    Path.expand("./lib/day_1/input.txt")
      |> File.read!()
      |> String.trim
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
  end
end
