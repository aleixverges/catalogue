defmodule Catalogue.Application.UpdatePriceHandler do
  @behaviour Commanded.Commands.Handler

  alias Catalogue.Domain.Product
  alias Catalogue.Domain.Messaging.Command.UpdatePrice

  def handle(%Product{} = aggregate, %UpdatePrice{uuid: uuid, price: price}) do
    Product.change_price(aggregate, price)
  end
end
