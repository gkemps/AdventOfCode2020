defmodule AdventOfCode.Day1 do
  @moduledoc false

  def firstToSumTo2020(list) do
    compareLists(list, list)
  end

  def compareLists([h1 | t1], [h2 | t2]) do
    if h1 + h2 == 2020 do
      IO.puts "#{h1} + #{h2} = 2020 => #{h1} x #{h2} = #{h1 * h2}"
    else
      compareLists([h1 | t1], t2)
    end
  end

  def compareLists([h1 | t1], []) do
      compareLists(t1, [h1 | t1])
  end

  def compareLists([], []) do
    nil
  end

end

{:ok, contents} = File.read("input.txt")
contents |> String.split("\n", trim: true) |> Enum.map(&String.to_integer/1) |> AdventOfCode.Day1.firstToSumTo2020() |> IO.inspect
