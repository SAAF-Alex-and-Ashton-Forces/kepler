defmodule Kepler.Repo.Migrations.AddNewUserFields do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string
      add :name, :string
    end
  end
end
