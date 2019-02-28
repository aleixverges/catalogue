defmodule Catalogue.Application.CreateProductHandler do
  @behaviour Commanded.Commands.Handler

  alias Catalogue.Domain.Product
  alias Catalogue.Domain.Messaging.Command.CreateProduct

  def handle(
        %Product{} = aggregate,
        %CreateProduct{uuid: uuid, name: name, description: description, price: price, stock: stock}
      ) do

    Product.create(aggregate, uuid, name, description, price, stock)
  end
end
