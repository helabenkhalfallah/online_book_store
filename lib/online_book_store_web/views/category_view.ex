defmodule OnlineBookStoreWeb.CategoryView do
  use OnlineBookStoreWeb, :view
  alias OnlineBookStoreWeb.CategoryView

  def render("index.json", %{category: category}) do
    %{data: render_many(category, CategoryView, "category.json")}
  end

  def render("show.json", %{category: category}) do
    %{data: render_one(category, CategoryView, "category.json")}
  end

  def render("category.json", %{category: category}) do
    %{id: category.id,
      name: category.name}
  end
end
