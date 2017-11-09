defmodule ClickAPI.Factory do
  alias ClickAPI.Counts.Click
  use ExMachina.Ecto, repo: ClickAPI.Repo

  def click_factory do
    %Click{}
  end
end
