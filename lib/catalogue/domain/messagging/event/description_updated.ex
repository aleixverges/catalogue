defmodule Catalogue.Domain.Messaging.Event.DescriptionUpdated do
  defstruct [:uuid, :previous_description, :description]
end
