defmodule Day8 do
  @moduledoc false

  def changeInput(list, index) do
    case elem(Enum.at(list, index), 0) do
      "acc" -> list
      "jmp" -> List.replace_at(list, index, {"nop", elem(Enum.at(list, index), 1), elem(Enum.at(list, index), 2)})
      "nop" -> List.replace_at(list, index, {"jmp", elem(Enum.at(list, index), 1), elem(Enum.at(list, index), 2)})
    end
  end

  def nextOperation(list, nextOp, acc, pastOps) do
    if nextOp >= length(list) do
      {true, acc}
    else
      {newNextOp, newAcc} = applyOperation(list, nextOp, acc)

      case Enum.find(pastOps, fn x -> x == nextOp end) do
        nil -> nextOperation(list, newNextOp, newAcc, [nextOp | pastOps])
        _ -> {false, acc}
      end
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

  def duplicateList(list) do
    List.duplicate(list, length(list))
  end

  def accOnLoop() do
    {_, sum, _} =
       File.read!("input.txt")
      |> String.split("\n")
      |> Enum.map(&String.split_at(&1, 3))
      |> Enum.map(fn {left, right} ->
        Tuple.insert_at(String.split_at(String.trim(right), 1), 0, left)
      end)
      |> Enum.map(fn {l, m, r} ->
        {l, m, String.to_integer(r)}
      end)
      |> Day8.duplicateList()
      |> Enum.reduce({false, 0, 0}, fn x, acc ->
        IO.puts "***"
        {terminated, sum} = Day8.nextOperation(Day8.changeInput(x, elem(acc, 2)), 0, 0, [])
        IO.puts "term: #{terminated} sum: #{sum}"
        if terminated do
          {true, sum, elem(acc, 2) + 1}
        else
          {false, elem(acc, 1), elem(acc, 2) + 1}
        end
      end)

      sum
  end
end

Day8.accOnLoop()
|> IO.inspect
