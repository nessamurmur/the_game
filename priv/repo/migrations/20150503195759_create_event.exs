defmodule TheGame.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :type, :string
      add :lat, :integer
      add :long, :integer

      timestamps
    end
  end
end
