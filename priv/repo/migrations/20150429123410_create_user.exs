defmodule TheGame.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :username, :string
      add :key, :string
      add :lat, :integer
      add :long, :integer

      timestamps
    end
  end
end
