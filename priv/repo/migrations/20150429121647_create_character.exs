defmodule TheGame.Repo.Migrations.CreateCharacter do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string
      add :level, :integer
      add :class_id, :integer
      add :user_id, :integer

      timestamps
    end
  end
end
