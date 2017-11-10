defmodule ClickAPIWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :click_api

  plug Plug.Static,
    at: "/", from: :click_api, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Corsica,
    origins: "*",
    allow_headers: ~w{Origin X-Requested-With Content-Type Accept},
    allow_credentials: true,
    max_age: 600

  plug Plug.Session,
    store: :cookie,
    key: "_click_api_key",
    signing_salt: "daKA/i70"

  plug ClickAPIWeb.Router

  def init(_key, config) do
    if config[:load_from_system_env] do
      port = System.get_env("PORT") || raise "expected the PORT environment variable to be set"
      {:ok, Keyword.put(config, :http, [:inet6, port: port])}
    else
      {:ok, config}
    end
  end
end
