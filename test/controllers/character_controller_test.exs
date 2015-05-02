defmodule TheGame.CharacterControllerTest do
  use TheGame.ConnCase

  alias TheGame.Character
  alias TheGame.User
  @valid_params character: %{class_id: 42, name: "some content"}
  @invalid_params character: %{class_id: nil, name: nil, user_id: nil}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "GET /users/:id/characters", %{conn: conn} do
    user = Repo.insert %User{name: "Some name", key: "some key"}
    conn = get conn, user_character_path(conn, :index, user.key)
    assert json_response(conn, 200)["data"] == []
  end

  test "GET /users/:user_id/characters/:id", %{conn: conn} do
    user = Repo.insert %User{name: "Some name", key: "some key"}
    character = Repo.insert %Character{name: "some name", class_id: 1, user_id: user.id}
    conn = get conn, user_character_path(conn, :show, user.key, character)
    assert json_response(conn, 200)["data"] == %{
      "id" => character.id
    }
  end

  test "POST /user/:user_id/characters with valid data", %{conn: conn} do
    user = Repo.insert %User{name: "Some name", key: "some key"}
    conn = post conn, user_character_path(conn, :create, user.key), @valid_params
    assert json_response(conn, 200)["data"]["id"]
  end

  test "POST /users/:user_id/characters with invalid data", %{conn: conn} do
    user = Repo.insert %User{name: "Some name", key: "some key"}
    conn = post conn, user_character_path(conn, :create, user.key), @invalid_params
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "PUT /users/:user_id/characters/:id with valid data", %{conn: conn} do
    user = Repo.insert %User{name: "Some name", key: "some key"}
    character = Repo.insert %Character{name: "some name", class_id: 1, user_id: user.id}
    conn = put conn, user_character_path(conn, :update, user.key, character), @valid_params
    assert json_response(conn, 200)["data"]["id"]
  end

  test "PUT /users/:user_id/characters/:id with invalid data", %{conn: conn} do
    user = Repo.insert %User{name: "Some name", key: "some key"}
    character = Repo.insert %Character{name: "some name", class_id: 1, user_id: user.id}
    conn = put conn, user_character_path(conn, :update, user.key, character), @invalid_params
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "DELETE /user/:user_id/characters/:id", %{conn: conn} do
    user = Repo.insert %User{name: "Some name", key: "some key"}
    character = Repo.insert %Character{name: "some name", class_id: 1, user_id: user.id}
    conn = delete conn, user_character_path(conn, :delete, user.key, character)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Character, character.id)
  end
end
