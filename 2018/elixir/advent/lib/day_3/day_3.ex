defmodule Day3 do
  def part_one do
    read_file()
      |> Enum.map(&make_chunk/1)
      |> Enum.reduce(%{}, &allocate_chunk/2)
      |> Enum.count(fn {_key, val} -> val > 1 end)
  end

  def part_two() do
    chunked = read_file()
      |> Enum.map(&make_chunk/1)

    allocated = Enum.reduce(chunked, %{}, &allocate_chunk/2)

    Enum.find(chunked, fn x ->
      !Enum.any?(x[:claims], fn y ->
        # IO.inspect allocated[y]
        allocated[y][:count] > 1
      end)
    end)
      |> Map.fetch!(:id)
  end

  defp read_file do
    Path.expand("./lib/day_3/input.txt")
      |> File.read!()
      |> String.trim
      |> String.split("\n", trim: true)
  end

  defp make_chunk(chunk_line) do
    [num, _at, corner, dim] = String.split(chunk_line)
    [corner_x, corner_y] = String.split(corner, [",", ":"], trim: true) |> Enum.map(fn x -> String.to_integer(x) + 1 end)
    [width, height] = String.split(dim, "x", trim: true) |> Enum.map(&String.to_integer/1)
    {id_num, _} = Integer.parse(String.slice(num, 1..-1))

    %{id: id_num, claims: Enum.reduce(0..(width-1), [], fn(x, acc) -> 
      acc ++ Enum.reduce(0..(height-1), [], fn(y, col) ->
        col ++ ["#{corner_x + x},#{corner_y + y}"]
      end)
    end)}
  end

  defp allocate_chunk(chunk, map) do
    Enum.reduce(chunk[:claims], map, fn (x, acc) -> 
      Map.update(acc, x, %{count: 1, claims: [chunk[:id]]}, fn (map) -> %{count: map[:count] + 1, claims: map[:claims] ++ [chunk[:id]]} end)
    end)
  end
end