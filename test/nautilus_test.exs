defmodule NautilusTest do
  use ExUnit.Case
  doctest Nautilus

  test "greets the world" do
    assert Nautilus.hello() == :world
  end
end
