File.read!("input.txt")
  |> String.trim
  |> String.split("\n", trim: true)
  |> Enum.reduce(0, fn(x, acc) ->
      {min, max} = String.split(x)
        |> Enum.min_max_by(fn(x) -> String.to_integer(x) end)
      acc + (String.to_integer(max) - String.to_integer(min))
    end)
  |> IO.puts
