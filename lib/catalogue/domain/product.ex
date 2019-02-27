defmodule Catalogue.Domain.Product do

  defstruct [:uuid, :name, :description, :price, :stock]

  alias Catalogue.Domain.Product
  alias Catalogue.Domain.Messaging.Event.ProductCreated
  alias Catalogue.Domain.Messaging.Event.StockIncremented
  alias Catalogue.Domain.Messaging.Event.StockDecreased
  alias Catalogue.Domain.Messaging.Event.PriceUpdated
  alias Catalogue.Domain.Messaging.Event.ProductRenamed
  alias Catalogue.Domain.Messaging.Event.DescriptionUpdated

  def create(%Product{uuid: nil}, uuid, name, description, price, stock) when price > 0
  do
    %ProductCreated{
      uuid: uuid,
      name: name,
      description: description,
      price: price,
      stock: stock
    }
  end

  def create(%Product{uuid: nil}, _uuid, _name, _description, price, _stock) when price <= 0
  do
    {:error, :unable_to_create_product_with_invalid_price}
  end

  def increase_stock(product = %Product{}, stock_increment) do
    %StockIncremented{
      uuid: product.uuid,
      previous_stock: product.stock,
      stock: product.stock + stock_increment
    }
  end

  def decrease_stock(product = %Product{}, stock_decrement) do
    cond do
      product.stock < stock_decrement ->
        {:error, :unable_to_decrease_stock_below_zero}
      true ->
        %StockDecreased{
          uuid: product.uuid,
          previous_stock: product.stock,
          stock: product.stock - stock_decrement
        }
    end
  end

  def change_price(product = %Product{}, price) do
    %PriceUpdated{
      uuid: product.uuid,
      previous_price: product.price,
      price: price
    }
  end

  def rename(product = %Product{}, new_name) do
    %ProductRenamed{
      uuid: product.uuid,
      previous_name: product.name,
      name: new_name
    }
  end

  def update_description(product = %Product{}, new_description) do
    %DescriptionUpdated{
      uuid: product.uuid,
      previous_description: product.description,
      description: new_description
    }
  end
end
