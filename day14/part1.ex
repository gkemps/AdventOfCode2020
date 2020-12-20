defmodule Day14 do
  @moduledoc false

  defp updateMemory(values, memory, mask) do
    {Map.put(memory, Enum.at(values, 0), valueAfterMask(Integer.to_string(Enum.at(values, 1), 2), mask)), mask}
  end

  defp valueAfterMask(value, mask) do
    String.to_integer(mask(String.pad_leading(value, 36, "0"), mask), 2)
  end

  defp mask(value, mask) do
    Enum.reduce(Enum.with_index(String.graphemes(mask)), "", fn {x, i}, acc ->
      case x do
        "X" -> acc <> String.slice(value, i..i)
        _   -> acc <> x
      end
    end)
  end

  def run() do
    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.reduce({Map.new(), ""}, fn x, {memory, mask} ->
      if String.contains?(x, "mask = ") do
        {memory, String.replace(x, "mask = ", "")}
      else
        updateMemory(Enum.map(List.flatten(Regex.scan(~r/\d+/, x)), &String.to_integer/1), memory, mask)
      end
    end)
    |> elem(0)
    |> Enum.reduce(0, fn {_, x}, acc -> acc + x end)
  end
end

Day14.run()
|> IO.inspect
