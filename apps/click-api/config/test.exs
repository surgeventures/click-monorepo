use Mix.Config

config :click_api, ClickAPIWeb.Endpoint,
  http: [port: 4001],
  server: false

config :logger, level: :warn

config :click_api, ClickAPI.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "click_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

import_config "test.local.exs"
