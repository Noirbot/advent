File.read!("input.txt")
  |> String.trim
  |> String.split("\n", trim: true)
  |> Enum.reduce(0, fn(x, acc) ->
      pass = String.split(x)
      if Enum.count(Enum.uniq(pass)) == Enum.count(pass) do
        acc + 1
      else
        acc
      end
    end)
  |> IO.puts
