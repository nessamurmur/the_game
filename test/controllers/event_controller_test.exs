defmodule TheGame.EventControllerTest do
  use TheGame.ConnCase

  alias TheGame.Event
  @valid_params event: %{lat: 42, long: 42, type: "some content"}
  @invalid_params event: %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "GET /events", %{conn: conn} do
    conn = get conn, event_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "GET /events/:id", %{conn: conn} do
    event = Repo.insert %Event{}
    conn = get conn, event_path(conn, :show, event)
    assert json_response(conn, 200)["data"] == %{
      "id" => event.id
    }
  end

  test "POST /events with valid data", %{conn: conn} do
    conn = post conn, event_path(conn, :create), @valid_params
    assert json_response(conn, 200)["data"]["id"]
  end

  test "POST /events with invalid data", %{conn: conn} do
    conn = post conn, event_path(conn, :create), @invalid_params
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "PUT /events/:id with valid data", %{conn: conn} do
    event = Repo.insert %Event{}
    conn = put conn, event_path(conn, :update, event), @valid_params
    assert json_response(conn, 200)["data"]["id"]
  end

  test "PUT /events/:id with invalid data", %{conn: conn} do
    event = Repo.insert %Event{}
    conn = put conn, event_path(conn, :update, event), @invalid_params
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "DELETE /events/:id", %{conn: conn} do
    event = Repo.insert %Event{}
    conn = delete conn, event_path(conn, :delete, event)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Event, event.id)
  end
end
