defmodule OnlineBookStoreWeb.PurchaseControllerTest do
  use OnlineBookStoreWeb.ConnCase

  alias OnlineBookStore.PurchaseSchema
  alias OnlineBookStore.PurchaseSchema.Purchase

  @create_attrs %{
    delivery_address: "some delivery_address",
    delivery_date: ~D[2010-04-17],
    user_id: 42
  }
  @update_attrs %{
    delivery_address: "some updated delivery_address",
    delivery_date: ~D[2011-05-18],
    user_id: 43
  }
  @invalid_attrs %{delivery_address: nil, delivery_date: nil, user_id: nil}

  def fixture(:purchase) do
    {:ok, purchase} = PurchaseSchema.create_purchase(@create_attrs)
    purchase
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all purchase", %{conn: conn} do
      conn = get(conn, Routes.purchase_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create purchase" do
    test "renders purchase when data is valid", %{conn: conn} do
      conn = post(conn, Routes.purchase_path(conn, :create), purchase: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.purchase_path(conn, :show, id))

      assert %{
               "id" => id,
               "delivery_address" => "some delivery_address",
               "delivery_date" => "2010-04-17",
               "user_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.purchase_path(conn, :create), purchase: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update purchase" do
    setup [:create_purchase]

    test "renders purchase when data is valid", %{conn: conn, purchase: %Purchase{id: id} = purchase} do
      conn = put(conn, Routes.purchase_path(conn, :update, purchase), purchase: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.purchase_path(conn, :show, id))

      assert %{
               "id" => id,
               "delivery_address" => "some updated delivery_address",
               "delivery_date" => "2011-05-18",
               "user_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, purchase: purchase} do
      conn = put(conn, Routes.purchase_path(conn, :update, purchase), purchase: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete purchase" do
    setup [:create_purchase]

    test "deletes chosen purchase", %{conn: conn, purchase: purchase} do
      conn = delete(conn, Routes.purchase_path(conn, :delete, purchase))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.purchase_path(conn, :show, purchase))
      end
    end
  end

  defp create_purchase(_) do
    purchase = fixture(:purchase)
    %{purchase: purchase}
  end
end
