# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :click_api,
  namespace: ClickAPI,
  ecto_repos: [ClickAPI.Repo]

# Configures the endpoint
config :click_api, ClickAPIWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "x5/wIDQMSO9+bvroF82peQJGX6XmTcYkmpY6t/1IQYAdNaLNGmGmJcdso+AIx1Xe",
  render_errors: [view: ClickAPIWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ClickAPI.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
