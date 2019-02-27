defmodule Catalogue.Domain.Messaging.Event.ProductCreatedTest do
  use ExUnit.Case

  alias Catalogue.Domain.Messaging.Event.ProductCreated

  test "should store product created event data" do
    uuid = 12345
    name = "some name"
    description = "some description"
    price = 10.10
    stock = 10

    event = %ProductCreated{uuid: uuid, name: name, description: description, price: price, stock: stock}

    assert uuid == event.uuid
    assert name == event.name
    assert description == event.description
    assert price == event.price
    assert stock == event.stock
  end
end
