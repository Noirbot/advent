File.read!("input.txt")
  |> String.trim
  |> String.split("\n", trim: true)
  |> Enum.reduce(0, fn(x, acc) ->
      pass = String.split(x)
          |> Enum.map(fn(x) ->
               String.codepoints(x)
               |> Enum.sort
               |> Enum.reduce(fn(x, acc) -> acc <> x end)
             end )
      if Enum.count(Enum.uniq(pass)) == Enum.count(pass) do
        acc + 1
      else
        acc
      end
    end)
  |> IO.puts
