defmodule ClickClient.Application do
  use Application
  alias ClickClientWeb.Endpoint

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Endpoint, []),
    ]

    opts = [strategy: :one_for_one, name: ClickClient.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Endpoint.config_change(changed, removed)
    :ok
  end
end
