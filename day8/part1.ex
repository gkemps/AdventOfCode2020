defmodule Day8 do
  @moduledoc false

  def nextOperation(list, nextOp, acc, pastOps) do
    {newNextOp, newAcc} = applyOperation(list, nextOp, acc)

    case Enum.find(pastOps, fn x -> x == nextOp end) do
      nil -> nextOperation(list, newNextOp, newAcc, [nextOp | pastOps])
      _ -> acc
    end
  end

  defp applyOperation(list, nextOp, acc) do
    IO.puts " #{elem(Enum.at(list, nextOp), 0)} #{elem(Enum.at(list, nextOp), 1)} #{elem(Enum.at(list, nextOp), 2)} acc: #{acc}"
    case elem(Enum.at(list, nextOp), 0) do
      "acc" -> case elem(Enum.at(list, nextOp), 1) do
                "+" -> {nextOp + 1, acc + elem(Enum.at(list, nextOp), 2)}
                "-" -> {nextOp + 1, acc - elem(Enum.at(list, nextOp), 2) }
               end
      "jmp" -> case elem(Enum.at(list, nextOp), 1) do
                 "+" -> {nextOp + elem(Enum.at(list, nextOp), 2), acc}
                 "-" -> {nextOp - elem(Enum.at(list, nextOp), 2), acc}
               end
      "nop" -> {nextOp + 1, acc}
    end
  end

  def accOnLoop() do
      File.read!("input.txt")
      |> String.split("\n")
      |> Enum.map(&String.split_at(&1, 3))
      |> Enum.map(fn {left, right} ->
        Tuple.insert_at(String.split_at(String.trim(right), 1), 0, left)
      end)
      |> Enum.map(fn {l, m, r} ->
        {l, m, String.to_integer(r)}
      end)
      |> Day8.nextOperation(0, 0, [])
  end
end

Day8.accOnLoop()
|> IO.inspect
