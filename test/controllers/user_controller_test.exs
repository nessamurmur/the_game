defmodule TheGame.UserControllerTest do
  use TheGame.ConnCase

  alias TheGame.User
  @valid_params user: %{key: "some content", lat: 42, long: 42, name: "some content", username: "some content"}
  @invalid_params user: %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "GET /users", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "GET /users/:id", %{conn: conn} do
    user = Repo.insert %User{key: "some key"}
    conn = get conn, user_path(conn, :show, user.key)
    assert json_response(conn, 200)["data"] == %{
      "id" => user.id
    }
  end

  test "POST /users with valid data", %{conn: conn} do
    conn = post conn, user_path(conn, :create), @valid_params
    assert json_response(conn, 200)["data"]["id"]
  end

  test "POST /users with invalid data", %{conn: conn} do
    conn = post conn, user_path(conn, :create), @invalid_params
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "PUT /users/:id with valid data", %{conn: conn} do
    user = Repo.insert %User{}
    conn = put conn, user_path(conn, :update, user), @valid_params
    assert json_response(conn, 200)["data"]["id"]
  end

  test "PUT /users/:id with invalid data", %{conn: conn} do
    user = Repo.insert %User{}
    conn = put conn, user_path(conn, :update, user), @invalid_params
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "DELETE /users/:id", %{conn: conn} do
    user = Repo.insert %User{}
    conn = delete conn, user_path(conn, :delete, user)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(User, user.id)
  end
end
