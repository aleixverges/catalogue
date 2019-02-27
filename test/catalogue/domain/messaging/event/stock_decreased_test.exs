defmodule Catalogue.Domain.Messaging.Event.StockDecreasedTest do
  use ExUnit.Case

  alias Catalogue.Domain.Messaging.Event.StockDecreased

  test "should contain stock decreased data" do
    uuid = 12345
    previous_stock = 10
    stock = 15

    event = %StockDecreased{uuid: uuid, previous_stock: previous_stock, stock: stock}

    assert uuid == event.uuid
    assert previous_stock == event.previous_stock
    assert stock == event.stock
  end
end
