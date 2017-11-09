defmodule ClickAPI.Counts do
  defmodule Click do
    use Ecto.Schema

    schema "clicks" do
      timestamps()
    end
  end

  alias ClickAPI.Repo

  def get do
    Repo.aggregate(Click, :count, :id)
  end

  def add do
    Repo.insert(%Click{})
    get()
  end
end
