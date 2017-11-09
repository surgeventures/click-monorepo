defmodule ClickAPI.Repo.Migrations.CreateClicks do
  use Ecto.Migration

  def change do
    create table("clicks") do
      timestamps()
    end
  end
end
