defmodule OnlineBookStoreWeb.AuthorView do
  use OnlineBookStoreWeb, :view
  alias OnlineBookStoreWeb.AuthorView

  def render("index.json", %{author: author}) do
    %{data: render_many(author, AuthorView, "author.json")}
  end

  def render("show.json", %{author: author}) do
    %{data: render_one(author, AuthorView, "author.json")}
  end

  def render("author.json", %{author: author}) do
    %{id: author.id,
      first_name: author.first_name,
      last_name: author.last_name,
      biography: author.biography}
  end
end
