defmodule Generator do
  @enforce_keys [:factor]
  defstruct [:factor, :divisor = 2147483647]
  def generate(gen, value) do
    return rem(value * gen.factor, gen.divisor)
  end

  def check(vals) do
    len = Enum.map(vals, fn x ->
      Integer.to_charlist(x, 2)
        |> String.pad_leading(16, '0')
        |> String.slice(-16..-1)
      end)
      |> Enum.uniq
      |> Enum.to_list
      |> List.length
    if len == 1 do
      return 1
    else
      return 0
    end
  end
end