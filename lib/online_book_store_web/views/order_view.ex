defmodule OnlineBookStoreWeb.OrderView do
  use OnlineBookStoreWeb, :view
  alias OnlineBookStoreWeb.OrderView

  def render("index.json", %{order: order}) do
    %{data: render_many(order, OrderView, "order.json")}
  end

  def render("show.json", %{order: order}) do
    %{data: render_one(order, OrderView, "order.json")}
  end

  def render("order.json", %{order: order}) do
    %{id: order.id,
      book_id: order.book_id,
      purchase_id: order.purchase_id,
      order_quantity: order.order_quantity}
  end
end
