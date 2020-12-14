defmodule Day10 do
  @moduledoc false

  def joltsDistribution() do
    dist =
      File.read!("input.txt")
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort
      |> Enum.reduce({0, 0, 0}, fn x, acc ->
          cond do
            x - elem(acc, 2) == 1 ->
              {elem(acc, 0) + 1, elem(acc, 1), x}
            x - elem(acc, 2) == 3 ->
              {elem(acc, 0), elem(acc, 1) + 1, x}
          end
      end)

    elem(dist, 0) * (elem(dist, 1) + 1)
  end
end

Day10.joltsDistribution()
|> IO.inspect
