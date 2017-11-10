use Mix.Config

config :click_client, ClickClient.CountsClient,
  url: "http://click-api:4000",
  front_url: "http://localhost:4000"
