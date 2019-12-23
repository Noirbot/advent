defmodule Day3 do
  def part_one() do
    read_file()
      |> Enum.map(&build_path/1)
      |> Enum.map(&Enum.uniq/1)
      |> Enum.reduce([], fn(path, trail) -> path ++ trail end)
      |> find_dupes
      |> List.delete({0, 0})
      |> Enum.map(fn({x, y}) -> abs(x) + abs(y) end)
      |> Enum.min
  end


  def part_two() do
    paths = read_file() |> Enum.map(&build_path/1)

    paths
      |> Enum.map(&Enum.uniq/1)
      |> Enum.reduce([], fn(path, trail) -> path ++ trail end)
      |> find_dupes
      |> List.delete({0, 0})
      |> Enum.map(fn(cross) ->
          Enum.reduce(paths, 0, fn(path, acc) ->
            index = Enum.find_index(Enum.reverse(path), fn(x) -> x == cross end)
            acc + index
          end)
        end)
      |> Enum.min
  end

  defp find_dupes(list) do
    uniques = Enum.uniq(list)
    list -- uniques
  end

  defp build_path(directions) do
    Enum.reduce(directions, [{0,0}], fn(step, trail) ->
      {dir, dist} = String.split_at(step, 1)
      dist = String.to_integer(dist)
      [ {x, y} | _ ] = trail
      case dir do
        "R" ->
          line = (x+dist)..(x+1)
            |> Enum.map(fn step_x -> {step_x, y} end)
          line ++ trail
        "L" ->
          line = (x-dist)..(x-1)
            |> Enum.map(fn step_x -> {step_x, y} end)
          line ++ trail
        "U" ->
          line = (y+dist)..(y+1)
            |> Enum.map(fn step_y -> {x, step_y} end)
          line ++ trail
        "D" ->
          line = (y-dist)..(y-1)
            |> Enum.map(fn step_y -> {x, step_y} end)
          line ++ trail
        _ ->
          IO.puts "What the hell?"
      end
    end)
  end

  defp read_file do
    Path.expand("./lib/day_3/input.txt")
      |> File.read!()
      |> String.trim
      |> String.split("\n", trim: true)
      |> Enum.map(fn(x) -> String.split(x, ",", trim: true) end)
  end
end
