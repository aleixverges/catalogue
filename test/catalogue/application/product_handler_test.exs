defmodule Catalogue.Application.CreateProductHandlerTest do
  use ExUnit.Case

  alias Catalogue.Domain.Product
  alias Catalogue.Domain.Messaging.Event.ProductCreated
  alias Catalogue.Domain.Messaging.Event.PriceUpdated
  alias Catalogue.Domain.Messaging.Event.StockDecreased

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

    assert expected == Catalogue.Application.ProductHandler.handle(product, command)
  end

  test "should perform price update" do
    uuid = "ABCDE"
    name = "some name"
    description = "description"
    price = 10.10
    new_price = 20.10
    stock = 10

    product = %Product{uuid: uuid, name: name, description: description, price: price, stock: stock}
    command = %Catalogue.Domain.Messaging.Command.UpdatePrice{uuid: uuid, price: new_price}
    expected = %PriceUpdated{uuid: uuid, previous_price: price, price: new_price,}

    assert expected == Catalogue.Application.ProductHandler.handle(product, command)
  end

  test "should perform stock decrease" do
    uuid = "ABCDE"
    name = "some name"
    description = "description"
    price = 10.10
    new_price = 20.10
    stock = 10
    stock_decrement = 2

    product = %Product{uuid: uuid, name: name, description: description, price: price, stock: stock}
    command = %Catalogue.Domain.Messaging.Command.DecreaseStock{uuid: uuid, stock_decrement: stock_decrement}
    expected = %StockDecreased{uuid: uuid, previous_stock: stock, stock: 8}

    assert expected == Catalogue.Application.ProductHandler.handle(product, command)
  end
end
