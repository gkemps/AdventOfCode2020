defmodule Day13 do
  @moduledoc false

  defp parse(input) do
      Enum.reduce(String.split(Enum.at(input, 1), ","), {[], 0}, fn x, {list, i} ->
        if x != "x" do
          {[{String.to_integer(x), i} | list], i + 1}
        else
          {list, i + 1}
        end
      end)
      |> elem(0)
      |> Enum.reverse
      |> findTimestamp(1)
  end

  defp findTimestamp([{num, pos} | tail], factor) do
    if loop(tail, factor * num) do
        factor * num
      else
        findTimestamp([{num, pos} | tail], factor + 1)
    end
  end

  defp loop([{num, pos} | tail], t) do
    IO.inspect {num, pos, t, rem(t + pos, num)}
    if rem(t + pos, num) == 0 do
      loop(tail, t)
    else
      false
    end
  end

  defp loop([], t) do
    true
  end

  def run() do
      File.read!("input.txt")
      |> String.split("\n")
      |> parse
  end
end

Day13.run()
|> IO.inspect