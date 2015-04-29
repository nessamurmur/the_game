defmodule TheGame.User do
  use TheGame.Web, :model

  schema "users" do
    field :name, :string
    field :username, :string
    field :key, :string
    field :lat, :integer
    field :long, :integer

    timestamps
  end

  @required_fields ~w(name username key lat long)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
