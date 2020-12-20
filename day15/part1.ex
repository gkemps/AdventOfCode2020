defmodule Day15 do
  @moduledoc false

  def elveGame({_history, 30000000, lastNumber}) do
    IO.puts "Number spoken: #{lastNumber}"
  end

  def elveGame({history, lastTurn, lastNumber}) do
    elveGame({Map.put(history, lastNumber, lastTurn), lastTurn + 1, newSpokenNumber(history, lastNumber, lastTurn)})
  end

  def newSpokenNumber(history, lastNumber, lastTurn) do
    if Map.has_key?(history, lastNumber) do
        lastTurn - Map.get(history, lastNumber)
      else
        0
    end
  end

  def run() do
    [5,1,9,18,13,8,0]
    |> Enum.with_index
    |> Enum.reduce({Map.new(), 0, 0}, fn {x, i}, {history, _turn, _last} ->
      {Map.put(history, x, i + 1), i + 1, x}
    end)
    |> elveGame
  end
end

Day15.run()
|> IO.inspect
