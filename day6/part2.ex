defmodule Day6 do
  @moduledoc false

  def numberQuestionsYes() do
    {_, nrQuestionsYes} =
      File.read!("input.txt")
      |> String.split("\n")
      |> Enum.map(&String.to_charlist/1)
      |> Enum.reduce({Enum.to_list(?a..?z), 0}, fn charlist, acc ->
        if length(charlist) == 0 do
          {Enum.to_list(?a..?z), elem(acc, 1) + length(elem(acc, 0))}
        else
          {MapSet.intersection(Enum.into(elem(acc,0), MapSet.new()), Enum.into(charlist, MapSet.new())) |> MapSet.to_list, elem(acc, 1)}
        end
      end)

     nrQuestionsYes
  end
end

Day6.numberQuestionsYes()
|> IO.puts()
