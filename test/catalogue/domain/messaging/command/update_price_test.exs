defmodule Catalogue.Domain.Messaging.Command.UpdatePriceTest do
  use ExUnit.Case

  alias Catalogue.Domain.Messaging.Command.UpdatePrice

  test "should store update price command data" do
    uuid = 12345
    price = 10.10

    command = %UpdatePrice{uuid: uuid, price: price}

    assert uuid == command.uuid
    assert price == command.price
  end
end
