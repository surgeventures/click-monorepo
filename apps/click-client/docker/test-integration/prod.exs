use Mix.Config

config :click_client, ClickClient.CountsClient,
  url: {:system, "API_URL"},
  front_url: {:system, "API_FRONT_URL"}

config :click_client, ClickClientWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "http", host: {:system, "HOST"}, port: 80],
  secret_key_base: {:system, "SECRET_KEY_BASE"}

config :logger, level: :info
