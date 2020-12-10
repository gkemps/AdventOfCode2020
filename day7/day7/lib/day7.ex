defmodule Day7 do
  @moduledoc false

  def part1() do
    Day7.createGraph()
    |> Graph.reachable_neighbors(["shiny gold"])
    |> Enum.count
  end

  def part2() do
    Day7.createGraph()
    |> count_bags("shiny gold")
    |> Kernel.-(1)
  end

  defp count_bags(graph, vertex) do
    graph
    |> Graph.out_edges(vertex)
    |> Enum.reduce(1, fn %{v2: vertex, label: n}, total ->
      total + n * count_bags(graph, vertex)
    end)
  end

  def createGraph() do
    File.read!("input.txt")
    |> String.trim
    |> String.split("\n")
    |> Enum.reduce(Graph.new(), fn line, graph ->
      [main, others] = line |> String.split(" contain ")
      main_parsed = main |> String.replace(" bags", "")

      others
      |> String.split([", ", "."], trim: true)
      |> Enum.map(fn other_str ->
        other_str
        |> String.replace([" bags", "bag"], "", global: true)
        |> Integer.parse()
        |> case do
             :error -> {0, "no bags"}
             {n, bag} -> {n, String.trim(bag)}
           end
      end)
      |> Enum.reduce(graph, fn {count, bag}, graph_acc ->
        case count do
          0 -> graph_acc
          _ -> Graph.add_edge(graph_acc, bag, main_parsed, label: count)
        end
      end)
    end)
  end
end