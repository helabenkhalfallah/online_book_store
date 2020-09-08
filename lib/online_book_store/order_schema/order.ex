defmodule OnlineBookStore.OrderSchema.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order" do
    field :book_id, :integer
    field :order_quantity, :integer
    field :purchase_id, :integer

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:book_id, :purchase_id, :order_quantity])
    |> validate_required([:book_id, :purchase_id, :order_quantity])
  end
end
