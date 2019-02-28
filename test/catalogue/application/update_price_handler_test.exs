defmodule Catalogue.Application.UpdatePriceHandlerTest do
  use ExUnit.Case

  alias Catalogue.Domain.Product
  alias Catalogue.Domain.Messaging.Event.PriceUpdated

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

    assert expected == Catalogue.Application.UpdatePriceHandler.handle(product, command)
  end
end
