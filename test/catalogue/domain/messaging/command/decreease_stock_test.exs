defmodule Catalogue.Domain.Messaging.Command.DecreaseStockTest do
  use ExUnit.Case

  alias Catalogue.Domain.Messaging.Command.DecreaseStock

  test "should store decrease stock command data" do
    uuid = 12345
    stock_decrement = 5

    command = %DecreaseStock{uuid: uuid, stock_decrement: stock_decrement}

    assert uuid == command.uuid
    assert stock_decrement == command.stock_decrement
  end
end
