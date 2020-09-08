defmodule OnlineBookStore.PurchaseSchema.Purchase do
  use Ecto.Schema
  import Ecto.Changeset

  schema "purchase" do
    field :delivery_address, :string
    field :delivery_date, :date
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(purchase, attrs) do
    purchase
    |> cast(attrs, [:user_id, :delivery_date, :delivery_address])
    |> validate_required([:user_id, :delivery_date, :delivery_address])
  end
end
