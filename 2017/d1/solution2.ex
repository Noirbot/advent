input = File.read!("input.txt")
  |> String.trim
len = String.length(input)

Enum.reduce(0..len, 0, fn(x, acc) ->
  cond do
    String.at(input, x) == String.at(input, rem((x + div(len, 2)), len)) ->
      acc + String.to_integer(String.at(input, x))
    true ->
      acc
  end
end )
  |> IO.puts
