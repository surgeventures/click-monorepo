defmodule ClickAPIWeb do
  def controller do
    quote do
      use Phoenix.Controller, namespace: ClickAPIWeb
      import Plug.Conn
      import ClickAPIWeb.Router.Helpers
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/click_api_web/templates",
                        namespace: ClickAPIWeb

      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      import ClickAPIWeb.Router.Helpers
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
