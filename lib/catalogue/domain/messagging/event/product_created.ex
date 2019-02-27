defmodule Catalogue.Domain.Messaging.Event.ProductCreated do
  defstruct [:uuid, :name, :description, :price, :stock]
end
