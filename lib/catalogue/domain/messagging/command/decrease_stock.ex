defmodule Catalogue.Domain.Messaging.Command.DecreaseStock do
  @enforce_keys [:uuid]
  defstruct [:uuid, :stock_decrement]
end
