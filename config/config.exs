# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :online_book_store,
  ecto_repos: [OnlineBookStore.Repo]

# Configures the endpoint
config :online_book_store, OnlineBookStoreWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MYyMOCxRaCjbQ+3FZ67y+it/AJWguh6TTHCAxAT7WfJw1jeCnEI4Z2DWNPLVTUBd",
  render_errors: [view: OnlineBookStoreWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: OnlineBookStore.PubSub,
  live_view: [signing_salt: "HpfhktRb"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
