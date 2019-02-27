defmodule Catalogue.Domain.Messaging.Event.StockIncrementedTest do
  use ExUnit.Case

  alias Catalogue.Domain.Messaging.Event.StockIncremented

  test "should contain stock incremented data" do
    uuid = 12345
    previous_stock = 10
    stock = 15

    event = %StockIncremented{uuid: uuid, previous_stock: previous_stock, stock: stock}

    assert uuid == event.uuid
    assert previous_stock == event.previous_stock
    assert stock == event.stock
  end
end
