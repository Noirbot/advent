defmodule Day2 do
  def part_one do
    read_file()
      |> Enum.map(fn x ->
          String.split(x, "", trim: true)
            |> Enum.sort
            |> Enum.chunk_by(fn x -> x end)
            |> Enum.map(&Enum.count/1)
            |> Enum.sort
            |> Enum.uniq
        end)
      |> Enum.reduce({0, 0}, fn(x, {twos, threes}) ->
          twos = if Enum.member?(x, 2) do
            twos + 1
          else
            twos
          end

          threes = if Enum.member?(x, 3) do
            threes + 1
          else
            threes
          end

          {twos, threes}
        end)
      |> Tuple.to_list
      |> Enum.reduce(fn x, acc -> x * acc end)
  end

  def part_two() do
    read_file()
      |> find_matches
  end

  defp read_file do
    Path.expand("./lib/day_2/input.txt")
      |> File.read!()
      |> String.trim
      |> String.split("\n", trim: true)
  end

  defp find_matches([line | rest]) do
    rest
      |> Enum.map(&String.myers_difference(&1, line))
      |> Enum.find(&check?/1)
      |> case do
        nil -> find_matches(rest)
        x -> find_equal(x)
      end
  end

  defp check?(diff_list) do
    diff_list
      |> Keyword.get_values(:del)
      |> List.to_string()
      |> (&(String.length(&1) === 1)).()
  end

  defp find_equal(diff_list) do
    diff_list
      |> Keyword.get_values(:eq)
      |> List.to_string()
  end
end