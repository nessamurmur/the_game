defmodule TheGame.Event do
  use TheGame.Web, :model

  schema "events" do
    field :type, :string
    field :lat, :integer
    field :long, :integer

    timestamps
  end

  @required_fields ~w(type lat long)
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
