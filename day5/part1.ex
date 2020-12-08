defmodule Day5 do
  @moduledoc false

  def seatNumber({head, tail}) do
#    IO.puts "head: #{String.replace(String.replace(head, "B", "1"), "F", "0")} tail: #{String.replace(String.replace(tail, "R", "1"), "L", "0")}"
    String.to_integer(String.replace(String.replace(head, "B", "1"), "F", "0"), 2) * 8 + String.to_integer(String.replace(String.replace(tail, "R", "1"), "L", "0"), 2)
  end

  def calcMaxSeatNumber() do
    maxSeatNumber =
      File.read!("input.txt")
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.split_at(&1, 7))
      |> Enum.reduce(0, fn row, maxSeatNumber ->
        max(maxSeatNumber, seatNumber(row))
      end)

    maxSeatNumber
  end
end

Day5.calcMaxSeatNumber()
|> IO.puts()