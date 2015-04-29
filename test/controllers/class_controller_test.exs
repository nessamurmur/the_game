defmodule TheGame.ClassControllerTest do
  use TheGame.ConnCase

  alias TheGame.Class
  @valid_params class: %{name: "some content"}
  @invalid_params class: %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "GET /classes", %{conn: conn} do
    conn = get conn, class_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "GET /classes/:id", %{conn: conn} do
    class = Repo.insert %Class{}
    conn = get conn, class_path(conn, :show, class)
    assert json_response(conn, 200)["data"] == %{
      "id" => class.id
    }
  end

  test "POST /classes with valid data", %{conn: conn} do
    conn = post conn, class_path(conn, :create), @valid_params
    assert json_response(conn, 200)["data"]["id"]
  end

  test "POST /classes with invalid data", %{conn: conn} do
    conn = post conn, class_path(conn, :create), @invalid_params
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "PUT /classes/:id with valid data", %{conn: conn} do
    class = Repo.insert %Class{}
    conn = put conn, class_path(conn, :update, class), @valid_params
    assert json_response(conn, 200)["data"]["id"]
  end

  test "PUT /classes/:id with invalid data", %{conn: conn} do
    class = Repo.insert %Class{}
    conn = put conn, class_path(conn, :update, class), @invalid_params
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "DELETE /classes/:id", %{conn: conn} do
    class = Repo.insert %Class{}
    conn = delete conn, class_path(conn, :delete, class)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Class, class.id)
  end
end
