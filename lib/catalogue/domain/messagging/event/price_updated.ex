defmodule Catalogue.Domain.Messaging.Event.PriceUpdated do
  defstruct [:uuid, :previous_price, :price]
end
