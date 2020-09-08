defmodule OnlineBookStoreWeb.BookControllerTest do
  use OnlineBookStoreWeb.ConnCase

  alias OnlineBookStore.Schema
  alias OnlineBookStore.Schema.Book

  @create_attrs %{
    author_id: 42,
    category_id: 42,
    description: "some description",
    image_url: "some image_url",
    isbn: "some isbn",
    original_price: 120.5,
    published_on: ~D[2010-04-17],
    title: "some title"
  }
  @update_attrs %{
    author_id: 43,
    category_id: 43,
    description: "some updated description",
    image_url: "some updated image_url",
    isbn: "some updated isbn",
    original_price: 456.7,
    published_on: ~D[2011-05-18],
    title: "some updated title"
  }
  @invalid_attrs %{author_id: nil, category_id: nil, description: nil, image_url: nil, isbn: nil, original_price: nil, published_on: nil, title: nil}

  def fixture(:book) do
    {:ok, book} = Schema.create_book(@create_attrs)
    book
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all book", %{conn: conn} do
      conn = get(conn, Routes.book_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create book" do
    test "renders book when data is valid", %{conn: conn} do
      conn = post(conn, Routes.book_path(conn, :create), book: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.book_path(conn, :show, id))

      assert %{
               "id" => id,
               "author_id" => 42,
               "category_id" => 42,
               "description" => "some description",
               "image_url" => "some image_url",
               "isbn" => "some isbn",
               "original_price" => 120.5,
               "published_on" => "2010-04-17",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.book_path(conn, :create), book: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update book" do
    setup [:create_book]

    test "renders book when data is valid", %{conn: conn, book: %Book{id: id} = book} do
      conn = put(conn, Routes.book_path(conn, :update, book), book: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.book_path(conn, :show, id))

      assert %{
               "id" => id,
               "author_id" => 43,
               "category_id" => 43,
               "description" => "some updated description",
               "image_url" => "some updated image_url",
               "isbn" => "some updated isbn",
               "original_price" => 456.7,
               "published_on" => "2011-05-18",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, book: book} do
      conn = put(conn, Routes.book_path(conn, :update, book), book: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete book" do
    setup [:create_book]

    test "deletes chosen book", %{conn: conn, book: book} do
      conn = delete(conn, Routes.book_path(conn, :delete, book))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.book_path(conn, :show, book))
      end
    end
  end

  defp create_book(_) do
    book = fixture(:book)
    %{book: book}
  end
end
