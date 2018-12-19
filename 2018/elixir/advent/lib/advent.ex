defmodule Advent do
  def day_1 do
    Day1.part_one() |> IO.inspect(label: "Day 1, Part 1")
    Day1.part_two() |> IO.inspect(label: "Day 1, Part 2")
  end

  def day_2 do
    Day2.part_one() |> IO.inspect(label: "Day 2, Part 1")
    Day2.part_two() |> IO.inspect(label: "Day 2, Part 2")
  end

  def day_3 do
    Day3.part_one() |> IO.inspect(label: "Day 3, Part 1")
    Day3.part_two() |> IO.inspect(label: "Day 3, Part 2")
  end

  def day_4 do
    Day4.part_one() |> IO.inspect(label: "Day 4, Part 1", charlists: false)
    Day4.part_two() |> IO.inspect(label: "Day 4, Part 2", charlists: false)
  end
end
