defmodule TheGame.User do
  use TheGame.Web, :model

  alias TheGame.Repo

  schema "users" do
    field :name, :string
    field :username, :string
    field :key, :string
    field :lat, :integer
    field :long, :integer

    timestamps
  end

  @required_fields ~w(name key)
  @optional_fields ~w(username lat long)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_unique(:key, on: Repo)
  end
end
