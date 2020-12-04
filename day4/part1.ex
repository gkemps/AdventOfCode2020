defmodule Day4 do
  @moduledoc false

  def numberOfValidPassports() do
    {_, validPassports} =
      File.read!("input.txt")
      #|> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.split(&1, ~r/:((\w|#)*)(\s)*/, trim: true))
      |> Enum.reduce({0, 0}, fn row, {nrItemsInPassport, nrOfValidPassports} ->
        {nrItemsInPassport, nrOfValidPassports} =
          case length(row) do
            n when n == 0 -> {0, nrOfValidPassports + div(nrItemsInPassport, 7)}
            _ -> {nrItemsInPassport + length(List.delete(row,"cid")), nrOfValidPassports}
          end

        {nrItemsInPassport, nrOfValidPassports}
      end)

    validPassports
  end
end

Day4.numberOfValidPassports()
|> IO.puts()