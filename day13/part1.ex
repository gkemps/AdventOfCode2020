defmodule Day13 do
  @moduledoc false

  defp parse(input) do
    timeToFirstBus(
      String.to_integer(Enum.at(input, 0)),
      Enum.map(
        Enum.filter(
          String.split(Enum.at(input, 1), ","),
          fn x -> x != "x" end
        ),
        &String.to_integer/1)
    )
  end

  defp timeToFirstBus(start, schedule) do
    Enum.reduce(schedule, [], fn x,acc ->
      [{x, x - rem(start, x)} | acc]
    end)
    |> Enum.reduce({0,999}, fn {busId, wait}, {minBusId, minWait} ->
        if wait < minWait do
          {busId, wait}
        else
          {minBusId, minWait}
        end
    end)
    |> (fn {x,y} -> x * y end).()
  end

  def run() do
      File.read!("input.txt")
      |> String.split("\n")
      |> parse
  end
end

Day13.run()
|> IO.inspect