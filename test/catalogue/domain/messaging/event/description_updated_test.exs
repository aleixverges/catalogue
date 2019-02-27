defmodule Catalogue.Domain.Messaging.Event.DescriptionUpdatedTest do
  use ExUnit.Case

  alias Catalogue.Domain.Messaging.Event.DescriptionUpdated

  test "should contain description updated data" do
    uuid = 12345
    previous_description = "some description"
    description = "some new description"

    event = %DescriptionUpdated{uuid: uuid, previous_description: previous_description, description: description}

    assert uuid == event.uuid
    assert previous_description == event.previous_description
    assert description == event.description
  end
end
