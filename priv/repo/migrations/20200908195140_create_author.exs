defmodule OnlineBookStore.Repo.Migrations.CreateAuthor do
  use Ecto.Migration

  def change do
    create table(:author) do
      add :first_name, :string
      add :last_name, :string
      add :biography, :string

      timestamps()
    end

  end
end
