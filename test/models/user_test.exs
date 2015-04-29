defmodule TheGame.UserTest do
  use TheGame.ModelCase

  alias TheGame.User

  @valid_attrs %{key: "some content", lat: 42, long: 42, name: "some content", username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
