defmodule ClickClientWeb.PageController do
  use ClickClientWeb, :controller
  alias ClickClient.CountsClient

  def index(conn, _params) do
    clicks = CountsClient.get
    url = CountsClient.front_url

    render conn, "index.html",
      clicks: clicks,
      url: url
  end
end
