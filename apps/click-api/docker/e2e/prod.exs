use Mix.Config

config :click_api, ClickAPI.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool_size: 10

config :click_api, ClickAPIWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "http", host: {:system, "HOST"}, port: 80],
  secret_key_base: {:system, "SECRET_KEY_BASE"}

config :logger, level: :info
