defmodule OnlineBookStore.Repo.Migrations.CreatePurchase do
  use Ecto.Migration

  def change do
    create table(:purchase) do
      add :user_id, :integer
      add :delivery_date, :date
      add :delivery_address, :string

      timestamps()
    end

  end
end
