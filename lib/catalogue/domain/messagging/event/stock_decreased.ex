defmodule Catalogue.Domain.Messaging.Event.StockDecreased do
  defstruct [:uuid, :previous_stock, :stock]
end
