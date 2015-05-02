defmodule TheGame.UserView do
  use TheGame.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{name: user.name, key: user.key, lat: user.lat, long: user.long}
  end
end
