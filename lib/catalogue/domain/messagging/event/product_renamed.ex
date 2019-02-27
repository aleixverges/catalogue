defmodule Catalogue.Domain.Messaging.Event.ProductRenamed do
  defstruct [:uuid, :previous_name, :name]
end
