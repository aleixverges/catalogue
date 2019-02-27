defmodule Catalogue.Domain.Messaging.Event.ProductRenamedTest do
  use ExUnit.Case

  alias Catalogue.Domain.Messaging.Event.ProductRenamed

  test "should contain product renamed data" do
    uuid = 12345
    previous_name = "Some name"
    new_name = "Some new name"

    event = %ProductRenamed{uuid: uuid, previous_name: previous_name, name: new_name}

    assert uuid == event.uuid
    assert previous_name == event.previous_name
    assert new_name == event.name
  end
end
