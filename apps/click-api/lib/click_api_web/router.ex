defmodule ClickAPIWeb.Router do
  use ClickAPIWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ClickAPIWeb do
    pipe_through :api

    resources "/clicks", ClickController, only: [:index, :create]
  end
end
