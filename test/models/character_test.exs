defmodule TheGame.CharacterTest do
  use TheGame.ModelCase

  alias TheGame.Character

  @valid_attrs %{class_id: 42, level: 42, name: "some content", user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Character.changeset(%Character{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Character.changeset(%Character{}, @invalid_attrs)
    refute changeset.valid?
  end
end
