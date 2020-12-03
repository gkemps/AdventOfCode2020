defmodule Day3 do
  @moduledoc false

  def countTrees({line, index}) do
    IO.puts "index: #{index} line: #{line}"

    if String.at(line, rem(index * 3, 31)) == "#" do
      true
    else
      false
    end
  end
end

File.stream!("input.txt")
|> Stream.map(&String.trim/1)
|> Stream.with_index
|> Enum.count(&Day3.countTrees/1)
|> IO.puts()

