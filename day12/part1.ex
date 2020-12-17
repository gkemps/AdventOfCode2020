defmodule Day12 do
  @moduledoc false

  defp changeDirection({e, n, dir}, {operation, value}) do
    case operation do
      "L" -> {e, n, Enum.at(["N","E","S","W"], Enum.find_index(["N","E","S","W"], fn x -> x == dir end) - div(value, 90))}
      "R" -> {e, n, Enum.at(["N","E","S","W"], rem(Enum.find_index(["N","E","S","W"], fn x -> x == dir end) + div(value, 90), 4))}
    end
  end

  defp moveForward({e,n,dir}, value) do
    case dir do
      "N" -> {e, n + value, dir}
      "S" -> {e, n - value, dir}
      "E" -> {e + value, n, dir}
      "W" -> {e - value, n, dir}
    end
  end

  def manhattanDistance() do
    {e,n,_} =
    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.map(&String.split_at(&1, 1))
    |> Enum.map(fn {operation, value} ->
      {operation, String.to_integer(value)}
    end)
    |> Enum.reduce({0, 0, "E"}, fn {operation, value}, {e,n,dir} ->
        IO.inspect {e,n,dir}
        IO.inspect {operation,value}

        case operation do
          "N" -> {e, n + value, dir}
          "S" -> {e, n - value, dir}
          "E" -> {e + value, n, dir}
          "W" -> {e - value, n, dir}
          "L" -> changeDirection({e,n,dir}, {operation,value})
          "R" -> changeDirection({e,n,dir}, {operation,value})
          "F" -> moveForward({e,n,dir}, value)
          _   -> {e,n,dir}
        end
    end)

    abs(e) + abs(n)
  end
end

Day12.manhattanDistance()
|> IO.inspect
