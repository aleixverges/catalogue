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

  test "should apply state when product created" do
    product_created = %ProductCreated{
      uuid: "ACC123",
      name: "some product name",
      description: "some product description",
      price: 10.10,
      stock: 20
    }

    product = Product.apply(%Product{}, product_created)

    assert product == %Product{
             uuid: product_created.uuid,
             name: product_created.name,
             description: product_created.description,
             price: product_created.price,
             stock: product_created.stock
           }
  end

  test "should apply state when product name updated" do
    product_renamed = %ProductRenamed{
      uuid: "ACC123",
      previous_name: "some product name",
      name: "some new product name"
    }

    existing_product = %Product{
      uuid: product_renamed.uuid,
      name: product_renamed.previous_name,
      description: "some description",
      price: 10.10,
      stock: 10
    }

    product = Product.apply(existing_product, product_renamed)

    assert product == %Product{
             uuid: product_renamed.uuid,
             name: product_renamed.name,
             description: "some description",
             price: 10.10,
             stock: 10
           }
  end

  test "should apply state when product price changed" do
    price_updated = %PriceUpdated{
      uuid: "ACC123",
      previous_price: 10.10,
      price: 20.10
    }

    existing_product = %Product{
      uuid: price_updated.uuid,
      name: 'some name',
      description: "some description",
      price: price_updated.previous_price,
      stock: 10
    }

    product = Product.apply(existing_product, price_updated)

    assert product == %Product{
             uuid: price_updated.uuid,
             name: 'some name',
             description: "some description",
             price: 20.10,
             stock: 10
           }
  end

  test "should apply state when product description updated" do
    description_updated = %DescriptionUpdated{
      uuid: "ACC123",
      previous_description: "some product description",
      description: "some new product description"
    }

    existing_product = %Product{
      uuid: description_updated.uuid,
      name: 'some name',
      description: description_updated.previous_description,
      price: 10.10,
      stock: 10
    }

    product = Product.apply(existing_product, description_updated)

    assert product == %Product{
             uuid: description_updated.uuid,
             name: 'some name',
             description: description_updated.description,
             price: 10.10,
             stock: 10
           }
  end

  test "should apply state when product stock decreased" do
    stock_decreased = %StockDecreased{
      uuid: "ACC123",
      previous_stock: 10,
      stock: 5
    }

    existing_product = %Product{
      uuid: stock_decreased.uuid,
      name: 'some name',
      description: "some description",
      price: 10.10,
      stock: stock_decreased.previous_stock
    }

    product = Product.apply(existing_product, stock_decreased)

    assert product == %Product{
             uuid: stock_decreased.uuid,
             name: 'some name',
             description: "some description",
             price: 10.10,
             stock: stock_decreased.stock
           }
  end

  test "should apply state when product stock increemented" do
    stock_incremented = %StockIncremented{
      uuid: "ACC123",
      previous_stock: 10,
      stock: 15
    }

    existing_product = %Product{
      uuid: stock_incremented.uuid,
      name: 'some name',
      description: "some description",
      price: 10.10,
      stock: stock_incremented.previous_stock
    }

    product = Product.apply(existing_product, stock_incremented)

    assert product == %Product{
             uuid: stock_incremented.uuid,
             name: 'some name',
             description: "some description",
             price: 10.10,
             stock: stock_incremented.stock
           }
  end

end
