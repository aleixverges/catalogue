defmodule Catalogue.Application.ProductRouter do
  use Commanded.Commands.Router

  alias Catalogue.Domain.Messaging.Command.CreateProduct
  alias Catalogue.Domain.Messaging.Command.UpdatePrice
  alias Catalogue.Application.ProductHandler

  identify Catalogue.Domain.Product, by: :uuid

  dispatch [CreateProduct,UpdatePrice], to: ProductHandler, aggregate: Catalogue.Domain.Product
end
