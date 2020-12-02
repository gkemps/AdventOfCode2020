defmodule AdventOfCode.Day2 do
  @moduledoc false

  def checkPasswordValid({lower, upper, char, password}) do
    (String.at(password, lower - 1) == char) != (String.at(password, upper - 1) == char)
  end
end

"./input.txt"
|> File.stream!([], :line)
|> Stream.map(&String.trim/1)
|> Stream.map(&String.split(&1, ~r/[-: ]/, trim: true))
|> Stream.map(fn[lo, hi, char, password]-> {String.to_integer(lo), String.to_integer(hi), char, password} end)
|> Enum.count(&AdventOfCode.Day2.checkPasswordValid/1)
|> IO.puts()
