defmodule OnlineBookStoreWeb.ReviewController do
  use OnlineBookStoreWeb, :controller

  alias OnlineBookStore.ReviewSchema
  alias OnlineBookStore.ReviewSchema.Review

  action_fallback OnlineBookStoreWeb.FallbackController

  def index(conn, _params) do
    review = ReviewSchema.list_review()
    render(conn, "index.json", review: review)
  end

  def create(conn, %{"review" => review_params}) do
    with {:ok, %Review{} = review} <- ReviewSchema.create_review(review_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.review_path(conn, :show, review))
      |> render("show.json", review: review)
    end
  end

  def show(conn, %{"id" => id}) do
    review = ReviewSchema.get_review!(id)
    render(conn, "show.json", review: review)
  end

  def update(conn, %{"id" => id, "review" => review_params}) do
    review = ReviewSchema.get_review!(id)

    with {:ok, %Review{} = review} <- ReviewSchema.update_review(review, review_params) do
      render(conn, "show.json", review: review)
    end
  end

  def delete(conn, %{"id" => id}) do
    review = ReviewSchema.get_review!(id)

    with {:ok, %Review{}} <- ReviewSchema.delete_review(review) do
      send_resp(conn, :no_content, "")
    end
  end
end
