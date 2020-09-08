defmodule OnlineBookStore.OrderSchemaTest do
  use OnlineBookStore.DataCase

  alias OnlineBookStore.OrderSchema

  describe "order" do
    alias OnlineBookStore.OrderSchema.Order

    @valid_attrs %{book_id: 42, order_quantity: 42, purchase_id: 42}
    @update_attrs %{book_id: 43, order_quantity: 43, purchase_id: 43}
    @invalid_attrs %{book_id: nil, order_quantity: nil, purchase_id: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> OrderSchema.create_order()

      order
    end

    test "list_order/0 returns all order" do
      order = order_fixture()
      assert OrderSchema.list_order() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert OrderSchema.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = OrderSchema.create_order(@valid_attrs)
      assert order.book_id == 42
      assert order.order_quantity == 42
      assert order.purchase_id == 42
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OrderSchema.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = OrderSchema.update_order(order, @update_attrs)
      assert order.book_id == 43
      assert order.order_quantity == 43
      assert order.purchase_id == 43
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = OrderSchema.update_order(order, @invalid_attrs)
      assert order == OrderSchema.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = OrderSchema.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> OrderSchema.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = OrderSchema.change_order(order)
    end
  end
end
