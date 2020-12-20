defmodule Day14 do
  @moduledoc false

  defp processExpr(values, memory, mask) do
    Enum.reduce(mask(String.pad_leading(Integer.to_string(Enum.at(values, 0), 2), 36, "0"), mask), memory, fn x, acc ->
      Map.put(acc, x, Enum.at(values, 1))
    end)
  end

  defp mask(value, mask) do
    Enum.reduce(Enum.with_index(String.graphemes(mask)), [""], fn {x, i}, acc ->
      case x do
        "X" -> Enum.map(acc, fn x -> x <> "0" end) ++ Enum.map(acc, fn x -> x <> "1" end)
        "1" -> Enum.map(acc, fn x -> x <> "1" end)
        "0" -> Enum.map(acc, fn x -> x <> String.slice(value, i..i) end)
      end
    end)
    |> Enum.map(&String.to_integer(&1, 2))
  end

  def run() do
    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.reduce({Map.new(), ""}, fn x, {memory, mask} ->
      if String.contains?(x, "mask = ") do
        {memory, String.replace(x, "mask = ", "")}
      else
        {processExpr(Enum.map(List.flatten(Regex.scan(~r/\d+/, x)), &String.to_integer/1), memory, mask), mask}
      end
    end)
    |> elem(0)
    |> Enum.reduce(0, fn {_, x}, acc -> acc + x end)
  end
end

Day14.run()
|> IO.inspect
