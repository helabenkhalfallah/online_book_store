defmodule OnlineBookStoreWeb.ReviewView do
  use OnlineBookStoreWeb, :view
  alias OnlineBookStoreWeb.ReviewView

  def render("index.json", %{review: review}) do
    %{data: render_many(review, ReviewView, "review.json")}
  end

  def render("show.json", %{review: review}) do
    %{data: render_one(review, ReviewView, "review.json")}
  end

  def render("review.json", %{review: review}) do
    %{id: review.id,
      user_id: review.user_id,
      book_id: review.book_id,
      rating: review.rating,
      comment: review.comment}
  end
end
