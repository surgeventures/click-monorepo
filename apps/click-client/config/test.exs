use Mix.Config

config :click_client, ClickClient.CountsClient,
  url: "http://example.com",
  mock: true

config :click_client, ClickClientWeb.Endpoint,
  http: [port: 4001],
  server: false

config :logger, level: :warn

import_config "test.local.exs"
