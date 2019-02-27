defmodule CatalogueTest do
  use ExUnit.Case
  doctest Catalogue

  test "greets the world" do
    assert Catalogue.hello() == :world
  end
end
