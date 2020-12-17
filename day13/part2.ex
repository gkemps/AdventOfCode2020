defmodule Day13 do
  @moduledoc false

  defp parse(input) do
      Enum.reduce(String.split(Enum.at(input, 1), ","), {[], 0}, fn x, {list, i} ->
        if x != "x" do
          {[{String.to_integer(x), i} | list], i + 1}
        else
          {list, i + 1}
        end
      end)
      |> elem(0)
      |> Enum.reverse
      |> Enum.reduce({0, 1}, &loop/2)
      |> elem(0)
  end

  defp loop({num, pos}, {t, step}) do
    IO.inspect {num, pos, t, step}
    if rem(t + pos, num) == 0 do
      {t, lcm(step, num)}
    else
      loop({num, pos}, {t + step, step})
    end
  end

  defp lcm(a, b) do
    div(a * b, Integer.gcd(a, b))
  end

  def run() do
      File.read!("input.txt")
      |> String.split("\n")
      |> parse
  end
end

Day13.run()
|> IO.inspect