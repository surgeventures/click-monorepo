defmodule ClickAPIWeb.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ConnTest
      import ClickAPIWeb.Router.Helpers

      @endpoint ClickAPIWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(ClickAPI.Repo)
    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(ClickAPI.Repo, {:shared, self()})
    end
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
