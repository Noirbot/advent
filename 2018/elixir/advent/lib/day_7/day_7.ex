defmodule Day7 do
  def part_one do
    dep_map = make_map()

    read_file()
      |> Enum.map(fn x -> Regex.named_captures(~r/Step (?<up>[A-Z])[a-z ]+(?<down>[A-Z]).+/, x) end)
      |> Enum.reduce(dep_map, fn x, acc -> Map.update(acc, x["down"], [x["up"]], &(&1 ++ [x["up"]])) end)
      |> solve_deps
  end

  def part_two do

  end

  defp read_file do
    Path.expand("./lib/day_7/input.txt")
      |> File.read!()
      |> String.trim
      |> String.split("\n", trim: true)
  end

  defp solve_deps(map) do
    rem_key = find_next_letter(map)

    if length(Map.keys(map)) > 1 do
      suffix = map
        |> clear_letter(rem_key)
        |> solve_deps
      
      rem_key <> suffix
    else
      rem_key
    end
  end

  defp find_next_letter(map) do
    Map.keys(map)
      |> Enum.sort
      |> Enum.find(fn x -> length(map[x]) === 0 end)
  end

  defp clear_letter(map, letter) do
    map
      |> Map.delete(letter)
      |> Enum.reduce(%{}, fn {k, v}, acc -> Map.put(acc, k, List.delete(v, letter)) end)
  end

  defp make_map() do
    nodes = for n <- ?A..?Z, do: << n :: utf8 >>
    
    Map.new(nodes, fn x -> {x, []} end)
  end
end