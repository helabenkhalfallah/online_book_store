defmodule OnlineBookStoreWeb.OrderController do
  use OnlineBookStoreWeb, :controller

  alias OnlineBookStore.OrderSchema
  alias OnlineBookStore.OrderSchema.Order

  action_fallback OnlineBookStoreWeb.FallbackController

  def index(conn, _params) do
    order = OrderSchema.list_order()
    render(conn, "index.json", order: order)
  end

  def create(conn, %{"order" => order_params}) do
    with {:ok, %Order{} = order} <- OrderSchema.create_order(order_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.order_path(conn, :show, order))
      |> render("show.json", order: order)
    end
  end

  def show(conn, %{"id" => id}) do
    order = OrderSchema.get_order!(id)
    render(conn, "show.json", order: order)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = OrderSchema.get_order!(id)

    with {:ok, %Order{} = order} <- OrderSchema.update_order(order, order_params) do
      render(conn, "show.json", order: order)
    end
  end

  def delete(conn, %{"id" => id}) do
    order = OrderSchema.get_order!(id)

    with {:ok, %Order{}} <- OrderSchema.delete_order(order) do
      send_resp(conn, :no_content, "")
    end
  end
end
