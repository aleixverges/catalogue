defmodule Catalogue.Domain.Messaging.Event.StockIncremented do
  defstruct [:uuid, :previous_stock, :stock]
end
