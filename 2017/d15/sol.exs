require Generator

values = [65, 8921]
factors = [16807, 48271]
gennies = [%Generator{factor: 16807}, %Generator{factor: 48271}]

Enum.reduce(0..4000000, 0, fn (iter, acc) -> 
    Enum.each(1..2, fn x ->
      values[x] = Generator.generate(gennies[x], values[x])
    end)

    return acc + Generator.check(values)
  end)
  |> IO.puts