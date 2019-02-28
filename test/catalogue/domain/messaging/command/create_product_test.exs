defmodule Catalogue.Domain.Messaging.Command.CreateProductTest do
  use ExUnit.Case

  alias Catalogue.Domain.Messaging.Command.CreateProduct

  test "should store create product command data" do
    uuid = 12345
    name = "some name"
    description = "some description"
    price = 10.10
    stock = 10

    event = %CreateProduct{uuid: uuid, name: name, description: description, price: price, stock: stock}

    assert uuid == event.uuid
    assert name == event.name
    assert description == event.description
    assert price == event.price
    assert stock == event.stock
  end
end
