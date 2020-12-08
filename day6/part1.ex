defmodule Day6 do
  @moduledoc false

  def numberQuestionsYes() do
    {_, nrQuestionsYes} =
      File.read!("input.txt")
      |> String.split("\n")
      |> Enum.map(&String.to_charlist/1)
      |> Enum.reduce({String.to_charlist(""), 0}, fn charlist, acc ->
        if length(charlist) == 0 do
          {[], elem(acc, 1) + length(Enum.uniq(elem(acc, 0)))}
        else
          {Enum.concat(elem(acc, 0), charlist), elem(acc, 1)}
        end
      end)

     nrQuestionsYes
  end
end

Day6.numberQuestionsYes()
|> IO.puts()
