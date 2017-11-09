use Mix.Config

config :click_client, ClickClient.CountsClient,
  url: "http://example.com",
  mock: true

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :click_client, ClickClientWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

import_config "test.local.exs"
