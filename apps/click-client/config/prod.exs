use Mix.Config

config :click_client, ClickClient.CountsClient,
  url: {:system, "API_URL"}

config :click_client, ClickClientWeb.Endpoint,
  load_from_system_env: true,
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :logger, level: :info

import_config "prod.secret.exs"
