defmodule OnlineBookStoreWeb.PurchaseController do
  use OnlineBookStoreWeb, :controller

  alias OnlineBookStore.PurchaseSchema
  alias OnlineBookStore.PurchaseSchema.Purchase

  action_fallback OnlineBookStoreWeb.FallbackController

  def index(conn, _params) do
    purchase = PurchaseSchema.list_purchase()
    render(conn, "index.json", purchase: purchase)
  end

  def create(conn, %{"purchase" => purchase_params}) do
    with {:ok, %Purchase{} = purchase} <- PurchaseSchema.create_purchase(purchase_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.purchase_path(conn, :show, purchase))
      |> render("show.json", purchase: purchase)
    end
  end

  def show(conn, %{"id" => id}) do
    purchase = PurchaseSchema.get_purchase!(id)
    render(conn, "show.json", purchase: purchase)
  end

  def update(conn, %{"id" => id, "purchase" => purchase_params}) do
    purchase = PurchaseSchema.get_purchase!(id)

    with {:ok, %Purchase{} = purchase} <- PurchaseSchema.update_purchase(purchase, purchase_params) do
      render(conn, "show.json", purchase: purchase)
    end
  end

  def delete(conn, %{"id" => id}) do
    purchase = PurchaseSchema.get_purchase!(id)

    with {:ok, %Purchase{}} <- PurchaseSchema.delete_purchase(purchase) do
      send_resp(conn, :no_content, "")
    end
  end
end
