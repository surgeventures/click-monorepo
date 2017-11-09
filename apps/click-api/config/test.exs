use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :click_api, ClickAPIWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :click_api, ClickAPI.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "click_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

import_config "test.local.exs"
