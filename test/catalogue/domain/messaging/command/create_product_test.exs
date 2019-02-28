defmodule Catalogue.Domain.Messaging.Command.CreateProductTest do
  use ExUnit.Case

  alias Catalogue.Domain.Messaging.Command.CreateProduct

  test "should store create product command data" do
    uuid = 12345
    name = "some name"
    description = "some description"
    price = 10.10
    stock = 10

    command = %CreateProduct{uuid: uuid, name: name, description: description, price: price, stock: stock}

    assert uuid == command.uuid
    assert name == command.name
    assert description == command.description
    assert price == command.price
    assert stock == command.stock
  end
end
