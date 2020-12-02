defmodule AdventOfCode.Day2 do
  @moduledoc false

  def checkPasswordInvalid(item) do
      list = String.split(item)
      bounds = String.split(Enum.at(list, 0), "-")
      lowerBound = String.to_integer(Enum.at(bounds, 0)) - 1
      upperBound = String.to_integer(Enum.at(bounds, 1)) - 1
      password = Enum.at(list, 2)
      char = String.slice(Enum.at(list, 1), 0..0)

      if (String.at(password, lowerBound) == char) != (String.at(password, upperBound) == char) do
        1
        else
        0
      end
  end
end

{:ok, contents} = File.read("input.txt")
contents |> String.split("\n", trim: true) |> Enum.map(&AdventOfCode.Day2.checkPasswordInvalid/1) |> Enum.sum() |> IO.inspect
