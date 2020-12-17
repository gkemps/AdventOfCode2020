defmodule Day12 do
  @moduledoc false

  defp rotateRight({{we,wn},{e,n,dir}}, value) do
    case div(value, 90) do
      1 -> {{wn,-1 * we},{e,n,dir}}
      2 -> {{-1 * we, -1 * wn},{e,n,dir}}
      3 -> {{-1 * wn,we},{e,n,dir}}
    end
  end

  def manhattanDistance() do
    {{_,_},{e,n,_}} =
    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.map(&String.split_at(&1, 1))
    |> Enum.map(fn {operation, value} ->
      {operation, String.to_integer(value)}
    end)
    |> Enum.reduce({{10,1},{0, 0, "E"}}, fn {operation, value}, {{we,wn},{e,n,dir}} ->
        IO.inspect {{we,wn},{e,n,dir}}
        IO.inspect {operation, value}
        IO.puts "***"

        case operation do
          "N" -> {{we,wn + value},{e,n,dir}}
          "S" -> {{we,wn - value},{e,n,dir}}
          "E" -> {{we + value,wn},{e,n,dir}}
          "W" -> {{we - value,wn},{e,n,dir}}
          "L" -> rotateRight({{we,wn},{e,n,dir}}, 360 - value)
          "R" -> rotateRight({{we,wn},{e,n,dir}}, value)
          "F" -> {{we,wn},{e + (value * we), n + (value * wn),dir}}
        end
    end)

    IO.inspect({e,n})

    abs(e) + abs(n)
  end
end

Day12.manhattanDistance()
|> IO.inspect
