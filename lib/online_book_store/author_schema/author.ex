defmodule OnlineBookStore.AuthorSchema.Author do
  use Ecto.Schema
  import Ecto.Changeset

  schema "author" do
    field :biography, :string
    field :first_name, :string
    field :last_name, :string

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:first_name, :last_name, :biography])
    |> validate_required([:first_name, :last_name, :biography])
  end
end
