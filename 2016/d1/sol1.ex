input = File.read!("input.txt")
  |> String.trim
  |> String.split(",", trim: true)

# [N, E, S, W]
dir = 0
x = 0
y = 0

Enum.each(input, fn(x) ->
  # Handle turning around
  case String.at(x, 0) do
    "L" ->
      dir = case dir do
        0 ->
          3
        true ->
          dir + 1
      end
    "R" ->
      dir = case dir do
        3 ->
          0
        true ->
          dir + 1
      end
    true -> "Error"
  end
  # Handle walking forward in the new direction.
  case dir do
    0 ->
      x = x + String.to_integer(String.slice(x, 1, -1))
    1 ->
      y = y + (String.slice(x, 1, -1) |> String.to_integer)
    2 ->
      x = x - (String.slice(x, 1, -1) |> String.to_integer)
    3 ->
      y = y - (String.slice(x, 1, -1) |> String.to_integer)
    true -> "Error"
  end
end )

IO.puts x <> ", " <> y
