defmodule OnlineBookStore.PurchaseSchemaTest do
  use OnlineBookStore.DataCase

  alias OnlineBookStore.PurchaseSchema

  describe "purchase" do
    alias OnlineBookStore.PurchaseSchema.Purchase

    @valid_attrs %{delivery_address: "some delivery_address", delivery_date: ~D[2010-04-17], user_id: 42}
    @update_attrs %{delivery_address: "some updated delivery_address", delivery_date: ~D[2011-05-18], user_id: 43}
    @invalid_attrs %{delivery_address: nil, delivery_date: nil, user_id: nil}

    def purchase_fixture(attrs \\ %{}) do
      {:ok, purchase} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PurchaseSchema.create_purchase()

      purchase
    end

    test "list_purchase/0 returns all purchase" do
      purchase = purchase_fixture()
      assert PurchaseSchema.list_purchase() == [purchase]
    end

    test "get_purchase!/1 returns the purchase with given id" do
      purchase = purchase_fixture()
      assert PurchaseSchema.get_purchase!(purchase.id) == purchase
    end

    test "create_purchase/1 with valid data creates a purchase" do
      assert {:ok, %Purchase{} = purchase} = PurchaseSchema.create_purchase(@valid_attrs)
      assert purchase.delivery_address == "some delivery_address"
      assert purchase.delivery_date == ~D[2010-04-17]
      assert purchase.user_id == 42
    end

    test "create_purchase/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PurchaseSchema.create_purchase(@invalid_attrs)
    end

    test "update_purchase/2 with valid data updates the purchase" do
      purchase = purchase_fixture()
      assert {:ok, %Purchase{} = purchase} = PurchaseSchema.update_purchase(purchase, @update_attrs)
      assert purchase.delivery_address == "some updated delivery_address"
      assert purchase.delivery_date == ~D[2011-05-18]
      assert purchase.user_id == 43
    end

    test "update_purchase/2 with invalid data returns error changeset" do
      purchase = purchase_fixture()
      assert {:error, %Ecto.Changeset{}} = PurchaseSchema.update_purchase(purchase, @invalid_attrs)
      assert purchase == PurchaseSchema.get_purchase!(purchase.id)
    end

    test "delete_purchase/1 deletes the purchase" do
      purchase = purchase_fixture()
      assert {:ok, %Purchase{}} = PurchaseSchema.delete_purchase(purchase)
      assert_raise Ecto.NoResultsError, fn -> PurchaseSchema.get_purchase!(purchase.id) end
    end

    test "change_purchase/1 returns a purchase changeset" do
      purchase = purchase_fixture()
      assert %Ecto.Changeset{} = PurchaseSchema.change_purchase(purchase)
    end
  end
end
