registers = %{}

File.read!("input.txt")
  |> String.trim
  |> String.split("\n", trim: true)
  |> Enum.each(fn(x) ->
      [reg1, action, val, z, reg2, comp, comp_val] = String.split(x)

      if registers[reg1] == nil do
        registers[reg1] = 0
      end

      if registers[reg2] == nil do
        registers[reg2] = 0
      end
    end)
  |> IO.puts
