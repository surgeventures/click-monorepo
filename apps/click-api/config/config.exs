use Mix.Config

config :click_api,
  namespace: ClickAPI,
  ecto_repos: [ClickAPI.Repo]

config :click_api, ClickAPIWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "x5/wIDQMSO9+bvroF82peQJGX6XmTcYkmpY6t/1IQYAdNaLNGmGmJcdso+AIx1Xe",
  render_errors: [view: ClickAPIWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ClickAPI.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env}.exs"
