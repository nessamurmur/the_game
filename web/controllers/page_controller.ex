defmodule TheGame.PageController do
  use TheGame.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
