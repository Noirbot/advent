defmodule Day6 do
  def part_one do
    input = read_file()
       
    x_max = Enum.max_by(input, &List.first/1) |> List.first
    y_max = Enum.max_by(input, &List.last/1) |> List.last
    
    Enum.reduce(0..x_max, %{}, fn x_val, x_acc ->
      Enum.reduce(0..y_max, x_acc, fn y_val, y_acc ->
        cur_point = [x_val, y_val]
        {b_point, dist} = find_closest(input, cur_point)
        if dist == -1 do
          y_acc
        else
          Map.update(y_acc, b_point, [cur_point], &(&1 ++ [cur_point]))
        end
      end)
    end)
      |> Enum.reduce(%{}, fn {key, value}, filtered -> 
        if !Enum.any?(value, fn [x, y] -> x == 0 || y == 0 || x == x_max || y == y_max end) do
          Map.put(filtered, key, length(value))
        else
          filtered
        end
      end)
      |> Enum.max_by(fn {_key, count} -> count end)
      |> Tuple.to_list
      |> List.last
  end

  def part_two do
    input = read_file()
       
    x_max = Enum.max_by(input, &List.first/1) |> List.first
    y_max = Enum.max_by(input, &List.last/1) |> List.last

    Enum.reduce(0..x_max, 0, fn x_val, x_acc ->
      Enum.reduce(0..y_max, x_acc, fn y_val, acc ->
        cur_point = [x_val, y_val]
        
        total_dist = input
          |> Enum.map(fn point -> manh_dist(point, cur_point) end)
          |> Enum.sum

        if total_dist < 10000 do
          acc + 1
        else
          acc
        end
      end)
    end)
  end

  defp read_file do
    Path.expand("./lib/day_6/input.txt")
      |> File.read!()
      |> String.trim
      |> String.split("\n", trim: true)
      |> Enum.map(fn x ->
        String.split(x, ", ", trim: true)
          |> Enum.map(&String.to_integer/1)
      end)
  end

  defp find_closest(points, cur_point) do
    chunks = points
      |> Enum.map(fn point -> {point, manh_dist(cur_point, point)} end)
      |> Enum.sort_by(fn {_point, dist} -> dist end)
      |> Enum.chunk_by(fn {_point, dist} -> dist end)
      
    if length(List.first(chunks)) > 1 do
      {[0, 0], -1}
    else
      chunks |> List.first |> List.first
    end
  end

  defp manh_dist(point1, point2) do
    [x1, y1] = point1
    [x2, y2] = point2
    abs(x1 - x2) + abs(y1 - y2)
  end
end