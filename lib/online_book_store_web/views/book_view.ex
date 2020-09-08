defmodule OnlineBookStoreWeb.BookView do
  use OnlineBookStoreWeb, :view
  alias OnlineBookStoreWeb.BookView

  def render("index.json", %{book: book}) do
    %{data: render_many(book, BookView, "book.json")}
  end

  def render("show.json", %{book: book}) do
    %{data: render_one(book, BookView, "book.json")}
  end

  def render("book.json", %{book: book}) do
    %{id: book.id,
      author_id: book.author_id,
      category_id: book.category_id,
      isbn: book.isbn,
      title: book.title,
      description: book.description,
      published_on: book.published_on,
      original_price: book.original_price,
      image_url: book.image_url}
  end
end
