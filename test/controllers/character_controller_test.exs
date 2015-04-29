defmodule TheGame.CharacterControllerTest do
  use TheGame.ConnCase

  alias TheGame.Character
  @valid_params character: %{class_id: 42, level: 42, name: "some content", user_id: 42}
  @invalid_params character: %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "GET /characters", %{conn: conn} do
    conn = get conn, character_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "GET /characters/:id", %{conn: conn} do
    character = Repo.insert %Character{}
    conn = get conn, character_path(conn, :show, character)
    assert json_response(conn, 200)["data"] == %{
      "id" => character.id
    }
  end

  test "POST /characters with valid data", %{conn: conn} do
    conn = post conn, character_path(conn, :create), @valid_params
    assert json_response(conn, 200)["data"]["id"]
  end

  test "POST /characters with invalid data", %{conn: conn} do
    conn = post conn, character_path(conn, :create), @invalid_params
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "PUT /characters/:id with valid data", %{conn: conn} do
    character = Repo.insert %Character{}
    conn = put conn, character_path(conn, :update, character), @valid_params
    assert json_response(conn, 200)["data"]["id"]
  end

  test "PUT /characters/:id with invalid data", %{conn: conn} do
    character = Repo.insert %Character{}
    conn = put conn, character_path(conn, :update, character), @invalid_params
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "DELETE /characters/:id", %{conn: conn} do
    character = Repo.insert %Character{}
    conn = delete conn, character_path(conn, :delete, character)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Character, character.id)
  end
end
