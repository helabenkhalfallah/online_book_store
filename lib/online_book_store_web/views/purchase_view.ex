defmodule OnlineBookStoreWeb.PurchaseView do
  use OnlineBookStoreWeb, :view
  alias OnlineBookStoreWeb.PurchaseView

  def render("index.json", %{purchase: purchase}) do
    %{data: render_many(purchase, PurchaseView, "purchase.json")}
  end

  def render("show.json", %{purchase: purchase}) do
    %{data: render_one(purchase, PurchaseView, "purchase.json")}
  end

  def render("purchase.json", %{purchase: purchase}) do
    %{id: purchase.id,
      user_id: purchase.user_id,
      delivery_date: purchase.delivery_date,
      delivery_address: purchase.delivery_address}
  end
end
