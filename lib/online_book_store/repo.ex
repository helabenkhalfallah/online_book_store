defmodule OnlineBookStore.Repo do
  use Ecto.Repo,
    otp_app: :online_book_store,
    adapter: Ecto.Adapters.Postgres
end
