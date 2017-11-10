use Mix.Config

config :click_api, ClickAPI.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool_size: 10

config :click_api, ClickAPIWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: {:system, "HOST"}, port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  secret_key_base: {:system, "SECRET_KEY_BASE"}

config :logger, level: :info
