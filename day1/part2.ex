defmodule AdventOfCode.Day1 do
  @moduledoc false

  def firstToSumTo2020(list) do
    compareLists(list, list, list)
  end

  def compareLists([h1 | t1], [h2 | t2], [h3 | t3]) do
    if h1 + h2 + h3 == 2020 do
      IO.puts "#{h1} + #{h2} + #{h3} = 2020 => #{h1} x #{h2} x #{h3} = #{h1 * h2 * h3}"
    else
      compareLists([h1 | t1], [h2 | t2], t3)
    end
  end

  def compareLists(l1, [h2 | t2], []) do
      compareLists(l1, t2, l1)
  end

  def compareLists([h1 | t1], [], l3) do
    compareLists(t1, [h1 | t1], [h1 | t1])
  end

  def compareLists([h1 | t1], [], []) do
    compareLists(t1, t1, t1)
  end

  def compareLists([], [], []) do
    nil
  end

end

{:ok, contents} = File.read("input.txt")
contents |> String.split("\n", trim: true) |> Enum.map(&String.to_integer/1) |> AdventOfCode.Day1.firstToSumTo2020() |> IO.inspect
