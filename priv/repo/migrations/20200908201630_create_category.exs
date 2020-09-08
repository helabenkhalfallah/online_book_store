defmodule OnlineBookStore.Repo.Migrations.CreateCategory do
  use Ecto.Migration

  def change do
    create table(:category) do
      add :name, :string

      timestamps()
    end

  end
end
