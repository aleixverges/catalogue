defmodule Catalogue.Domain.Messaging.Command.UpdatePriceTest do
  use ExUnit.Case

  alias Catalogue.Domain.Messaging.Command.UpdatePrice

  test "should store update price command data" do
    uuid = 12345
    price = 10.10

    event = %UpdatePrice{uuid: uuid, price: price}

    assert uuid == event.uuid
    assert price == event.price
  end
end
