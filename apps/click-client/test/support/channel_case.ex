defmodule ClickClientWeb.ChannelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ChannelTest

      @endpoint ClickClientWeb.Endpoint
    end
  end

  setup _tags do
    :ok
  end
end
