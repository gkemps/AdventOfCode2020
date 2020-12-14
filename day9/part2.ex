defmodule Day9 do
  @moduledoc false

  @my_goal 507622668

  def reduceBelowGoal(list, goal) do
    if Enum.sum(list) <= goal do
      list
    else
      reduceBelowGoal(Enum.drop(list, -1), goal)
    end
  end

  def xmasDecrypt() do
    list =
    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce([], fn x, acc ->
        cond do
          Enum.sum(acc) == @my_goal ->
            acc
          Enum.sum(acc) + x <= @my_goal ->
            [ x | acc ]
          Enum.sum(acc) + x > @my_goal ->
            reduceBelowGoal([ x | acc ], @my_goal)
        end
      end)
    |> Enum.sort

    Enum.at(list, 0) + Enum.at(list, length(list) - 1)
  end
end

Day9.xmasDecrypt()
|> IO.inspect