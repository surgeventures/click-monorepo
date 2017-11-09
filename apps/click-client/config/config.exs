# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :click_client, ClickClientWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "noBYg/nBqZBStJg4hvhZ5vM3sQ5dEr+FZN+TMbpeujUHgTHLRJwM4Y5NEGC3PKxl",
  render_errors: [view: ClickClientWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ClickClient.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
