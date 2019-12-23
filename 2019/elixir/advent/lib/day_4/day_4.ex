defmodule Day4 do
  def part_one() do
    get_input()
      |> Enum.filter(&check_pair/1)
      |> Enum.filter(&check_inc/1)
      |> Enum.count
  end


  def part_two() do
    get_input()
      |> Enum.filter(fn x -> check_pair(x, true) end)
      |> Enum.filter(&check_inc/1)
      |> Enum.count
  end

  defp check_pair(pass, strict \\ false) do
    pass
      |> to_string
      |> String.codepoints
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_by(&(&1))
      |> Enum.map(&Enum.count/1)
      |> Enum.any?(fn x ->
          if strict do
            x == 2
          else
            x >= 2
          end
        end)
  end

  defp check_inc(pass) do
    {valid, _} = pass
      |> to_string
      |> String.codepoints
      |> Enum.map(&String.to_integer/1)
      |> Enum.reduce_while({true, -1}, fn x, {_, last} ->
          if last > x do
            {:halt, {false, x}}
          else
            {:cont, {true, x}}
          end
        end)

    valid
  end

  defp get_input do
    "138241-674034"
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)
      |> (fn list -> List.first(list)..List.last(list) end).()
  end
end
