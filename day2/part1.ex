defmodule AdventOfCode.Day2 do
  @moduledoc false

  def checkPasswordInvalid(item) do
      list = String.split(item)
      bounds = String.split(Enum.at(list, 0), "-")
      if countCharacterInString(String.slice(Enum.at(list, 1), 0..0), Enum.at(list, 2)) < String.to_integer(Enum.at(bounds,0)) || countCharacterInString(String.slice(Enum.at(list, 1), 0..0), Enum.at(list, 2)) > String.to_integer(Enum.at(bounds,1)) do
        0
      else
        1
      end
  end

  def countCharacterInString(char, string) do
    String.graphemes(string) |> Enum.count(& &1 == char)
  end
end

{:ok, contents} = File.read("input.txt")
contents |> String.split("\n", trim: true) |> Enum.map(&AdventOfCode.Day2.checkPasswordInvalid/1) |> Enum.sum() |> IO.inspect
