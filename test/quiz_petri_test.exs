defmodule PetriTest do
  use ExUnit.Case

  # ──────────────────────────────────────────
  # Tests: Petri (lista de arcos)
  # ──────────────────────────────────────────

  test "lista de arcos: fire :a desde marcado inicial [:p0]" do
    f  = Petri.ex1l()
    m0 = MapSet.new([:p0])
    m1 = Petri.fire(f, :a, m0)
    assert m1 == MapSet.new([:p1, :p2])
  end

  test "lista de arcos: transición no habilitada no cambia el marcado" do
    f  = Petri.ex1l()
    m0 = MapSet.new([:p0])
    assert Petri.fire(f, :b, m0) == m0
  end

  test "lista de arcos: secuencia completa a -> d -> e llega a [:p5]" do
    f  = Petri.ex1l()
    m0 = MapSet.new([:p0])
    m1 = Petri.fire(f, :a, m0)   # => [:p1, :p2]
    m2 = Petri.fire(f, :d, m1)   # => [:p3, :p4]
    m3 = Petri.fire(f, :e, m2)   # => [:p5]
    assert m3 == MapSet.new([:p5])
  end

  # ──────────────────────────────────────────
  # Tests: Petri.Mapa (mapa pre/post)
  # ──────────────────────────────────────────

  test "mapa: fire :a desde marcado inicial [:p0]" do
    net = Petri.Mapa.ex1m()
    m0  = MapSet.new([:p0])
    m1  = Petri.Mapa.fire(net, :a, m0)
    assert m1 == MapSet.new([:p1, :p2])
  end

  test "mapa: transición no habilitada no cambia el marcado" do
    net = Petri.Mapa.ex1m()
    m0  = MapSet.new([:p0])
    assert Petri.Mapa.fire(net, :b, m0) == m0
  end

  test "mapa: enablement desde [:p0] solo habilita :a" do
    net = Petri.Mapa.ex1m()
    m0  = MapSet.new([:p0])
    assert Petri.Mapa.enablement(net, m0) == MapSet.new([:a])
  end

  test "mapa: secuencia completa a -> d -> e llega a [:p5]" do
    net = Petri.Mapa.ex1m()
    m0  = MapSet.new([:p0])
    m1  = Petri.Mapa.fire(net, :a, m0)   # => [:p1, :p2]
    m2  = Petri.Mapa.fire(net, :d, m1)   # => [:p3, :p4]
    m3  = Petri.Mapa.fire(net, :e, m2)   # => [:p5]
    assert m3 == MapSet.new([:p5])
  end
end
