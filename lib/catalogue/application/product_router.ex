defmodule Catalogue.Application.ProductRouter do
  use Commanded.Commands.Router

  alias Catalogue.Domain.Messaging.Command.CreateProduct
  alias Catalogue.Application.CreateProductHandler

  dispatch CreateProduct, to: CreateProductHandler, aggregate: Catalogue.Domain.Product, identity: :uuid
end
