defmodule Catalogue.Domain.Messaging.Event.PriceUpdatedTest do
  use ExUnit.Case

  alias Catalogue.Domain.Messaging.Event.PriceUpdated

  test "should contain price updated data" do
    uuid = 12345
    previous_price = 10.10
    price = 15.20

    event = %PriceUpdated{uuid: uuid, previous_price: previous_price, price: price}

    assert uuid == event.uuid
    assert previous_price == event.previous_price
    assert price == event.price
  end
end
