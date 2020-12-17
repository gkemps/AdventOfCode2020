defmodule Day11 do
  @moduledoc false

  defp transformSeats(list) do
    IO.inspect(list, limit: 100)
    if list == newList(list, [], 0) do
      list
    else
      transformSeats(newList(list, [], 0))
    end
  end

  defp newList(old, new, pos) do
    if length(new) == length(old) do
      Enum.reverse(new)
    else
      newList(old, [newSeat(old, pos) | new], pos + 1)
    end
  end

  defp determineNewSeat({neighbors, _}, list, pos) do
    case Enum.at(list, pos) do
      "L" -> if Enum.count(Enum.filter(neighbors, fn x -> x == "#" end)) == 0 do
              "#"
             else
              "L"
             end
      "#" -> if Enum.count(Enum.filter(neighbors, fn x -> x == "#" end)) >= 4 do
               "L"
             else
               "#"
             end
      _   -> Enum.at(list, pos)
    end
  end

  defp newSeat(list, pos) do
    Enum.reduce(list, {[], 0}, fn x, acc ->
      if abs(div(elem(acc, 1), 97)-div(pos, 97)) <= 1 and abs(rem(elem(acc, 1), 97)-rem(pos, 97)) <= 1 and elem(acc, 1) != pos do
        {[x] ++ elem(acc, 0), elem(acc, 1) + 1}
      else
        {elem(acc, 0), elem(acc, 1) + 1}
      end
    end)
    |> determineNewSeat(list, pos)
  end

  def occupiedSeats() do
      File.read!("input.txt")
      |> String.split("\n")
      |> Enum.reduce("", fn x, acc ->
        acc <> x
      end)
      |> String.graphemes
      |> transformSeats
      |> Enum.filter(fn x -> x == "#" end)
      |> Enum.count
  end
end

Day11.occupiedSeats()
|> IO.inspect()
