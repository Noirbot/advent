input = File.read!("input.txt")
  |> String.trim

Enum.reduce(0..String.length(input), 0, fn(x, acc) ->
  cond do
    String.at(input, x) == String.at(input, x-1) ->
      acc + String.to_integer(String.at(input, x))
    true ->
      acc
  end
end )
  |> IO.puts
