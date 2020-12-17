defmodule Day12 do
  @moduledoc false

  defp rotateRight({{we,wn},{e,n}}, value) do
    case div(value, 90) do
      1 -> {{wn,-1 * we},{e,n}}
      2 -> {{-1 * we, -1 * wn},{e,n}}
      3 -> {{-1 * wn,we},{e,n}}
    end
  end

  def manhattanDistance() do
    {{_,_},{e,n}} =
    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.map(&String.split_at(&1, 1))
    |> Enum.map(fn {operation, value} ->
      {operation, String.to_integer(value)}
    end)
    |> Enum.reduce({{10,1},{0, 0}}, fn {operation, value}, {{we,wn},{e,n}} ->
        case operation do
          "N" -> {{we,wn + value},{e,n}}
          "S" -> {{we,wn - value},{e,n}}
          "E" -> {{we + value,wn},{e,n}}
          "W" -> {{we - value,wn},{e,n}}
          "L" -> rotateRight({{we,wn},{e,n}}, 360 - value)
          "R" -> rotateRight({{we,wn},{e,n}}, value)
          "F" -> {{we,wn},{e + (value * we), n + (value * wn)}}
        end
    end)

    abs(e) + abs(n)
  end
end

Day12.manhattanDistance()
|> IO.inspect
