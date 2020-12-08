defmodule Day5 do
  @moduledoc false

  def seatNumber({head, tail}) do
    String.to_integer(String.replace(String.replace(head, "B", "1"), "F", "0"), 2) * 8 + String.to_integer(String.replace(String.replace(tail, "R", "1"), "L", "0"), 2)
  end

  def calcMaxSeatNumber() do
    {_, mySeats} =
      File.read!("input.txt")
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.split_at(&1, 7))
      |> Enum.reduce([], fn row, list ->
        [seatNumber(row) | list]
      end)
      |> Enum.sort()
      |> Enum.reduce({37, []}, fn x, acc ->
          if x == elem(acc, 0) + 1 do
            {x, elem(acc, 1)}
          else
            {x, [x - 1 | elem(acc, 1)]}
          end
      end)

    mySeats
  end
end

Day5.calcMaxSeatNumber()
|> IO.inspect()