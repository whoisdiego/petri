defmodule Petri do

  def ex1l do
    [
      [:p0, :a],
      [:a, :p1],
      [:a, :p2],
      [:p1, :b],
      [:p1, :d],
      [:p2, :c],
      [:p2, :d],
      [:b, :p3],
      [:d, :p3],
      [:c, :p4],
      [:d, :p4],
      [:p3, :e],
      [:p4, :e],
      [:e, :p5]
    ]
  end

  def preset(f, n) do
    f
    |> Enum.filter(fn [_a, b] -> b == n end)
    |> Enum.map(fn [a, _b] -> a end)
    |> MapSet.new()
  end

  # Calcula el postset de un nodo: nodos hacia los que n tiene arco
  def postset(f, n) do
    f
    |> Enum.filter(fn [a, _b] -> a == n end)
    |> Enum.map(fn [_a, b] -> b end)
    |> MapSet.new()
  end

  # Verifica si una transición t está habilitada dado el marcado m
  def enabled?(f, t, m) do
    preset(f, t)
    |> MapSet.subset?(m)
  end

  def fire(f, t, m) do
    if enabled?(f, t, m) do
      m
      |> MapSet.difference(preset(f, t))
      |> MapSet.union(postset(f, t))
    else
      m
    end
  end

  # Devuelve el conjunto de transiciones habilitadas dado el marcado m
  def enablement(f, transitions, m) do
    transitions
    |> Enum.filter(fn t -> enabled?(f, t, m) end)
    |> MapSet.new()
  end
end
