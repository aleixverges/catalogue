defmodule Catalogue.Application.ProductHandler do
  @behaviour Commanded.Commands.Handler

  alias Catalogue.Domain.Product
  alias Catalogue.Domain.Messaging.Command.CreateProduct
  alias Catalogue.Domain.Messaging.Command.UpdatePrice
  alias Catalogue.Domain.Messaging.Command.DecreaseStock

  def handle(
        %Product{} = aggregate,
        %CreateProduct{uuid: uuid, name: name, description: description, price: price, stock: stock}
      ) do

    Product.create(aggregate, uuid, name, description, price, stock)
  end

  def handle(%Product{} = aggregate, %UpdatePrice{uuid: uuid, price: price}) do
    Product.change_price(aggregate, price)
  end

  def handle(%Product{} = aggregate, %DecreaseStock{uuid: uuid, stock_decrement: stock_decrement}) do
    Product.decrease_stock(aggregate, stock_decrement)
  end
end
