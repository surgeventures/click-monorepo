use Mix.Config

config :click_api, ClickAPI.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "click_api_dev",
  hostname: "localhost",
  pool_size: 10

config :click_api, ClickAPIWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

import_config "dev.local.exs"
