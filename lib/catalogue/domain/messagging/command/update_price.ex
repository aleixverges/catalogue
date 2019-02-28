defmodule Catalogue.Domain.Messaging.Command.UpdatePrice do
  @enforce_keys [:uuid]
  defstruct [:uuid, :price]
end
