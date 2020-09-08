defmodule OnlineBookStoreWeb.BookController do
  use OnlineBookStoreWeb, :controller

  alias OnlineBookStore.Schema
  alias OnlineBookStore.Schema.Book

  action_fallback OnlineBookStoreWeb.FallbackController

  def index(conn, _params) do
    book = Schema.list_book()
    render(conn, "index.json", book: book)
  end

  def create(conn, %{"book" => book_params}) do
    with {:ok, %Book{} = book} <- Schema.create_book(book_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.book_path(conn, :show, book))
      |> render("show.json", book: book)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Schema.get_book!(id)
    render(conn, "show.json", book: book)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Schema.get_book!(id)

    with {:ok, %Book{} = book} <- Schema.update_book(book, book_params) do
      render(conn, "show.json", book: book)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Schema.get_book!(id)

    with {:ok, %Book{}} <- Schema.delete_book(book) do
      send_resp(conn, :no_content, "")
    end
  end
end
