defmodule OnlineBookStore.Repo.Migrations.CreateReview do
  use Ecto.Migration

  def change do
    create table(:review) do
      add :user_id, :integer
      add :book_id, :integer
      add :rating, :integer
      add :comment, :string

      timestamps()
    end

  end
end
