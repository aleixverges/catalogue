defmodule Catalogue.Domain.Messaging.Command.CreateProduct do
  @enforce_keys [:uuid]
  defstruct [:uuid, :name, :description, :price, :stock]
end
