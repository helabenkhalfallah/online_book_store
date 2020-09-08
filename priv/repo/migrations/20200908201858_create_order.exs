defmodule OnlineBookStore.Repo.Migrations.CreateOrder do
  use Ecto.Migration

  def change do
    create table(:order) do
      add :book_id, :integer
      add :purchase_id, :integer
      add :order_quantity, :integer

      timestamps()
    end

  end
end
