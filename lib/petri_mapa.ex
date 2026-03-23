defmodule Petri.Mapa do
  @moduledoc """
  Representación de Red de Petri usando un mapa de pre/post condiciones.
  Cada transición es clave y su valor contiene :pre y :post explícitos.
  Acceso a preset/postset en O(1) vs O(n) de la lista de arcos.
  """

  @doc "Red de ejemplo codificada como mapa de transiciones con pre y post"
  def ex1m do
    %{
      :a => %{pre: [:p0],       post: [:p1, :p2]},
      :b => %{pre: [:p1],       post: [:p3]},
      :c => %{pre: [:p2],       post: [:p4]},
      :d => %{pre: [:p1, :p2],  post: [:p3, :p4]},
      :e => %{pre: [:p3, :p4],  post: [:p5]}
    }
  end

  @doc "Verifica si la transición t está habilitada dado el marcado m"
  def enabled?(network, t, m) do
    %{pre: pre} = network[t]
    MapSet.subset?(MapSet.new(pre), m)
  end

  @doc """
  Dispara la transición t sobre el marcado m.
  Si t está habilitada: M' = (M \\ •t) ∪ t•
  Si no está habilitada: devuelve m sin cambios.
  """
  def fire(network, t, m) do
    %{pre: pre, post: post} = network[t]
    pre_set = MapSet.new(pre)

    if MapSet.subset?(pre_set, m) do
      m
      |> MapSet.difference(pre_set)
      |> MapSet.union(MapSet.new(post))
    else
      m
    end
  end

  @doc "Devuelve el conjunto de transiciones habilitadas dado el marcado m"
  def enablement(network, m) do
    network
    |> Map.keys()
    |> Enum.filter(fn t -> enabled?(network, t, m) end)
    |> MapSet.new()
  end
end
