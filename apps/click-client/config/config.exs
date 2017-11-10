use Mix.Config

config :click_client, ClickClientWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "noBYg/nBqZBStJg4hvhZ5vM3sQ5dEr+FZN+TMbpeujUHgTHLRJwM4Y5NEGC3PKxl",
  render_errors: [view: ClickClientWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ClickClient.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env}.exs"
