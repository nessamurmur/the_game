defmodule TheGame.Character do
  use TheGame.Web, :model

  alias TheGame.Repo
  alias TheGame.Class

  schema "characters" do
    field :name, :string
    field :level, :integer
    field :class_id, :integer
    field :user_id, :integer

    timestamps
  end

  @required_fields ~w(name class_id user_id)
  @optional_fields ~w(level)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:name, min: 1)
    |> validate_number(:user_id, greater_than: 0)
    |> validate_number(:class_id, greater_than: 0)
  end

  def class_for(character) do
    class = Repo.one(from c in Class, where: c.id == ^character.class_id)
    if class do
      class.name
    else
      ""
    end
  end
end
