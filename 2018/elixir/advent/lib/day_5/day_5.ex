defmodule Day5 do
  def part_one do
    read_file() |> collapse_string_to_len
  end

  def part_two() do
    input = read_file()
    ?a..?z
      |> Enum.to_list
      |> List.to_string
      |> String.split("", trim: true)
      |> Enum.map(fn char ->
        len = String.replace(input, String.upcase(char), "")
          |> String.replace(char, "")
          |> collapse_string_to_len

        %{char: char, length: len}
      end)
      |> Enum.min_by(&(&1.length))
      |> (&(&1.length)).()
  end

  defp read_file do
    Path.expand("./lib/day_5/input.txt")
      |> File.read!()
      |> String.trim
  end

  defp collapse_string_to_len(input) do
    String.split(input, "", trim: true)
      |> recur_filter
      |> String.length
  end

  defp recur_filter(split_string) do
    start_len = length(split_string)

    filtered_string = split_string
      |> Enum.chunk_by(&String.downcase/1)
      |> Enum.reduce("", fn(x, acc) -> acc <> recur_chunk(x) end)
    
    if start_len == String.length(filtered_string) do
      filtered_string
    else
      recur_filter(String.split(filtered_string, "", trim: true))
    end
  end

  defp recur_chunk(chunk) do
    if length(chunk) >= 2 do
      [one | tail] = chunk
      if one == List.first(tail) do
        one <> recur_chunk(tail)
      else
        [_match | rest] = tail
        recur_chunk(rest)
      end
    else
      Enum.join(chunk)
    end
  end
end