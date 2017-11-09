defmodule ClickAPIWeb.ClickController do
  use ClickAPIWeb, :controller
  alias ClickAPI.Counts

  def index(conn, _params) do
    count = Counts.get

    json conn, %{count: count}
  end

  def create(conn, _params) do
    count = Counts.add

    json conn, %{count: count}
  end
end
