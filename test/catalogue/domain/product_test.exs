defmodule Catalogue.ProductTest do
  use ExUnit.Case

  alias Catalogue.Domain.Product
  alias Catalogue.Domain.Messaging.Event.ProductCreated
  alias Catalogue.Domain.Messaging.Event.StockIncremented
  alias Catalogue.Domain.Messaging.Event.StockDecreased
  alias Catalogue.Domain.Messaging.Event.PriceUpdated
  alias Catalogue.Domain.Messaging.Event.ProductRenamed
  alias Catalogue.Domain.Messaging.Event.DescriptionUpdated

  test "should create product" do
    product = %Product{}
    uuid = "ACC123"
    name = "some product name"
    description = "some product description"
    price = 10.10
    stock = 20

    event = Product.create(product, uuid, name, description, price, stock)

    assert event == %ProductCreated{
             uuid: "ACC123",
             name: "some product name",
             description: "some product description",
             price: 10.10,
             stock: 20
           }
  end

  test "should prevent create product with price 0" do
    product = %Product{}
    uuid = "ACC123"
    name = "some product name"
    description = "some product description"
    price = 0.0
    stock = 20

    error = Product.create(product, uuid, name, description, price, stock)

    assert error == {:error, :unable_to_create_product_with_invalid_price}
  end

  test "should prevent create product with price below zero" do
    product = %Product{}
    uuid = "ACC123"
    name = "some product name"
    description = "some product description"
    price = -10.0
    stock = 20

    error = Product.create(product, uuid, name, description, price, stock)

    assert error == {:error, :unable_to_create_product_with_invalid_price}
  end

  test "should increase stock" do
    product = %Product{uuid: "ACC123", name: "some product", description: "some description", price: 10.10, stock: 10}
    stock_increment = 5

    event = Product.increase_stock(product, stock_increment)

    assert event == %StockIncremented{
             uuid: "ACC123",
             previous_stock: 10,
             stock: 15
           }
  end

  test "should decrease stock" do
    product = %Product{uuid: "ACC123", name: "some product", description: "some description", price: 10.10, stock: 10}
    stock_decrement = 5

    event = Product.decrease_stock(product, stock_decrement)

    assert event == %StockDecreased{
             uuid: "ACC123",
             previous_stock: 10,
             stock: 5
           }
  end

  test "should fail when trying to decrease stock below zero" do
    product = %Product{uuid: "ACC123", name: "some product", description: "some description", price: 10.10, stock: 5}
    stock_decrement = 10

    error = Product.decrease_stock(product, stock_decrement)

    assert error == {:error, :unable_to_decrease_stock_below_zero}
  end

  test "should change product price" do
    product = %Product{uuid: "ACC123", name: "some product", description: "some description", price: 10.10, stock: 10}
    new_price = 15

    event = Product.change_price(product, new_price)

    assert event == %PriceUpdated{
             uuid: "ACC123",
             previous_price: 10.10,
             price: 15
           }
  end

  test "should not change the price when existing is the same as the new" do
    product = %Product{uuid: "ACC123", name: "some product", description: "some description", price: 10.10, stock: 10}
    new_price = 10.10

    result = Product.change_price(product, new_price)

    assert result == {:ok, :price_not_changed}
  end

  test "should rename product" do
    product = %Product{uuid: "ACC123", name: "some product", description: "some description", price: 10.10, stock: 10}
    new_name = "Some new product name"

    event = Product.rename(product, new_name)

    assert event == %ProductRenamed{
             uuid: "ACC123",
             previous_name: "some product",
             name: "Some new product name"
           }
  end

  test "product name should not change when changing with the same name" do
    product = %Product{uuid: "ACC123", name: "some product", description: "some description", price: 10.10, stock: 10}
    new_name = "some product"

    result = Product.rename(product, new_name)

    assert result == {:ok, :name_not_updated}
  end

  test "should update product description" do
    product = %Product{uuid: "ACC123", name: "some product", description: "some description", price: 10.10, stock: 10}
    new_description = "Some new description"

    event = Product.update_description(product, new_description)

    assert event == %DescriptionUpdated{
             uuid: "ACC123",
             previous_description: "some description",
             description: "Some new description"
           }
  end

  test "product description should not change when changing with the same description" do
    product = %Product{uuid: "ACC123", name: "some product", description: "some description", price: 10.10, stock: 10}
    new_description = "some description"

    result = Product.update_description(product, new_description)

    assert result == {:ok, :description_not_updated}
  end
end
