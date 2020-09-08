defmodule OnlineBookStore.ReviewSchemaTest do
  use OnlineBookStore.DataCase

  alias OnlineBookStore.ReviewSchema

  describe "review" do
    alias OnlineBookStore.ReviewSchema.Review

    @valid_attrs %{book_id: 42, comment: "some comment", rating: 42, user_id: 42}
    @update_attrs %{book_id: 43, comment: "some updated comment", rating: 43, user_id: 43}
    @invalid_attrs %{book_id: nil, comment: nil, rating: nil, user_id: nil}

    def review_fixture(attrs \\ %{}) do
      {:ok, review} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ReviewSchema.create_review()

      review
    end

    test "list_review/0 returns all review" do
      review = review_fixture()
      assert ReviewSchema.list_review() == [review]
    end

    test "get_review!/1 returns the review with given id" do
      review = review_fixture()
      assert ReviewSchema.get_review!(review.id) == review
    end

    test "create_review/1 with valid data creates a review" do
      assert {:ok, %Review{} = review} = ReviewSchema.create_review(@valid_attrs)
      assert review.book_id == 42
      assert review.comment == "some comment"
      assert review.rating == 42
      assert review.user_id == 42
    end

    test "create_review/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ReviewSchema.create_review(@invalid_attrs)
    end

    test "update_review/2 with valid data updates the review" do
      review = review_fixture()
      assert {:ok, %Review{} = review} = ReviewSchema.update_review(review, @update_attrs)
      assert review.book_id == 43
      assert review.comment == "some updated comment"
      assert review.rating == 43
      assert review.user_id == 43
    end

    test "update_review/2 with invalid data returns error changeset" do
      review = review_fixture()
      assert {:error, %Ecto.Changeset{}} = ReviewSchema.update_review(review, @invalid_attrs)
      assert review == ReviewSchema.get_review!(review.id)
    end

    test "delete_review/1 deletes the review" do
      review = review_fixture()
      assert {:ok, %Review{}} = ReviewSchema.delete_review(review)
      assert_raise Ecto.NoResultsError, fn -> ReviewSchema.get_review!(review.id) end
    end

    test "change_review/1 returns a review changeset" do
      review = review_fixture()
      assert %Ecto.Changeset{} = ReviewSchema.change_review(review)
    end
  end
end
