defmodule TheGame.PageControllerTest do
  use TheGame.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "The Game"
  end
end
