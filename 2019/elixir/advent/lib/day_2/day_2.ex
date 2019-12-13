defmodule Day2 do
  def part_one() do
    read_file()
      |> config(12, 2)
      |> process
  end

  def part_two() do
    base = read_file()
    target = 19690720

    Enum.reduce_while(0..99, {-1, -1}, fn(x, res) ->
      needle = Enum.find(0..99, -1, fn y ->
        output = base
                |> config(x, y)
                |> process
        output == target
      end)

      if needle == -1 do
        {:cont, res}
      else
        {:halt, 100 * x + needle}
      end
    end)
  end

  defp config(program, noun, verb) do
    program
      |> List.replace_at(1, noun)
      |> List.replace_at(2, verb)
  end

  defp process(program, index \\ 0) do
    code = Enum.at(program, index)
    case code do
      99 ->
        Enum.at(program, 0)
      1 ->
        [a, b, dest] = Enum.slice(program, index + 1, 3)
        List.replace_at(program, dest, Enum.at(program, a) + Enum.at(program, b))
          |> process(index + 4)
      2 ->
        [a, b, dest] = Enum.slice(program, index + 1, 3)
        List.replace_at(program, dest, Enum.at(program, a) * Enum.at(program, b))
          |> process(index + 4)
      _ ->
        IO.puts "What the hell?"
    end
  end

  defp read_file do
    Path.expand("./lib/day_2/input.txt")
      |> File.read!()
      |> String.trim
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
  end
end
