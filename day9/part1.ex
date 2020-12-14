defmodule Day9 do
  @moduledoc false

  def isValid([], _value) do
    false
  end

  def isValid([head | tail], value) do
    (Enum.find(tail, fn x -> x == (value - head) end) != nil) or isValid(tail, value)
  end

  def xmasDecrypt() do
    {_, wrong} =
    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce({[], 0}, fn x, acc ->
        if length(elem(acc,0)) < 25 do
          {[x | elem(acc, 0)], elem(acc,1)}
          else
            if !isValid(elem(acc,0), x) and elem(acc, 1) == 0 do
              {elem(acc, 0), x}
            else
              {[x | Enum.drop(elem(acc, 0), -1)], elem(acc,1)}
            end
        end
    end)

    wrong
  end
end

Day9.xmasDecrypt()
|> IO.inspect