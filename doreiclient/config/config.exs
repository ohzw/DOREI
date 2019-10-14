# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :doreiclient,
  ecto_repos: [Doreiclient.Repo]

# Configures the endpoint
config :doreiclient, DoreiclientWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/XCDnjq8t+5xE2NKsODvJDQaLNcwdmRJe1QzLDNO48ofvrzTMqQ8u3h2ZHtV6z/V",
  render_errors: [view: DoreiclientWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Doreiclient.PubSub, adapter: Phoenix.PubSub.PG2]

config :doreiclient, Doreiclient.Accounts.Guardian,
  issur: "doreiclient",
  secret_key: "9f+oHPdVUGBenVbaV20NPiH9NmXmAlPJ9p2i6eXG2mM7awFiP1PliGX4ecmGoP+0"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
