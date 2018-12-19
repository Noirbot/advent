defmodule Day4 do
  def part_one do
    read_file()
      |> build_stats
      |> Enum.max_by(fn x -> x.sum end)
      |> (&(List.first(&1.times) * String.to_integer(&1.guard))).()
  end

  def part_two() do
    read_file()
      |> build_stats
      |> Enum.max_by(fn x -> x.max end)
      |> (&(List.first(&1.times) * String.to_integer(&1.guard))).()
  end

  defp read_file do
    Path.expand("./lib/day_4/input.txt")
      |> File.read!()
      |> String.trim
      |> String.split("\n", trim: true)
  end

  defp parse_line(line) do
    %{"time" => timestamp, "action" => action, "id" => id} = 
      Regex.named_captures(~r/^\[(?<time>[\w-: ]+)\] (?<action>\w+) (?>#(?<id>\d+))?.+$/, line)
    
    {:ok, timestamp, _} = DateTime.from_iso8601(timestamp <> ":00Z")

    %{timestamp: timestamp, action: action, id: id}
  end

  defp process_wake(guard_map, guard_id, sleep_time) do
    guard_map = Map.put_new(guard_map, guard_id, %{})

    sleep_time
      |> Enum.reduce(guard_map, fn (x, map) ->
          id_map = Map.update(map[guard_id], x, 1, &(&1 + 1))
          Map.put(map, guard_id, id_map)
        end)
  end

  defp build_stats(lines) do
    lines
      |> Enum.map(&parse_line/1)
      |> Enum.sort_by(fn(x) -> {x[:timestamp].year, x[:timestamp].month, x[:timestamp].day, x[:timestamp].hour, x[:timestamp].minute, x[:timestamp].second} end)
      |> Enum.reduce({%{}, "", %{}},fn (x, {guards, gID, last}) ->
        case x[:action] do
          "Guard" -> {guards, x[:id], x}
          "falls" -> {guards, gID, x}
          "wakes" -> {process_wake(guards, gID, last[:timestamp].minute..x[:timestamp].minute-1), gID, x}
        end
      end)
      |> elem(0)
      |> Enum.map(fn {key, val} ->
        sum = val
          |> Map.values
          |> Enum.sum

        best = val
          |> Map.values
          |> Enum.max
        
        vals = Enum.reduce(val, [], fn {min, y}, acc -> 
          if y === best do
            [min | acc]
          else
            acc
          end
        end)

        %{max: best, times: vals, sum: sum, guard: key}
      end)
  end
end