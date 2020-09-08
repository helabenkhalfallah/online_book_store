defmodule OnlineBookStoreWeb.AuthorController do
  use OnlineBookStoreWeb, :controller

  alias OnlineBookStore.AuthorSchema
  alias OnlineBookStore.AuthorSchema.Author

  action_fallback OnlineBookStoreWeb.FallbackController

  def index(conn, _params) do
    author = AuthorSchema.list_author()
    render(conn, "index.json", author: author)
  end

  def create(conn, %{"author" => author_params}) do
    with {:ok, %Author{} = author} <- AuthorSchema.create_author(author_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.author_path(conn, :show, author))
      |> render("show.json", author: author)
    end
  end

  def show(conn, %{"id" => id}) do
    IO.inspect("Get book for id: #{id}")
    author = AuthorSchema.get_author!(id)
    render(conn, "show.json", author: author)
  end

  def update(conn, %{"id" => id, "author" => author_params}) do
    author = AuthorSchema.get_author!(id)

    with {:ok, %Author{} = author} <- AuthorSchema.update_author(author, author_params) do
      render(conn, "show.json", author: author)
    end
  end

  def delete(conn, %{"id" => id}) do
    author = AuthorSchema.get_author!(id)

    with {:ok, %Author{}} <- AuthorSchema.delete_author(author) do
      send_resp(conn, :no_content, "")
    end
  end
end
