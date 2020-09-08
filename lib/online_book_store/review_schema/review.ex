defmodule OnlineBookStore.ReviewSchema.Review do
  use Ecto.Schema
  import Ecto.Changeset

  schema "review" do
    field :book_id, :integer
    field :comment, :string
    field :rating, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:user_id, :book_id, :rating, :comment])
    |> validate_required([:user_id, :book_id, :rating, :comment])
  end
end
