defmodule Catalogue.Application.CreateProductHandlerTest do
  use ExUnit.Case

  alias Catalogue.Domain.Product
  alias Catalogue.Domain.Messaging.Event.ProductCreated

  test "should perform product creation" do
    uuid = "ABCDE"
    name = "some name"
    description = "description"
    price = 10.10
    stock = 10

    product = %Product{}
    command = %Catalogue.Domain.Messaging.Command.CreateProduct{
      uuid: uuid,
      name: name,
      description: description,
      price: price,
      stock: stock
    }

    expected = %ProductCreated{
      uuid: uuid,
      name: name,
      description: description,
      price: price,
      stock: stock
    }

    assert expected == Catalogue.Application.CreateProductHandler.handle(product, command)
  end
end