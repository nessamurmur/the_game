defmodule TheGame.ClassView do
  use TheGame.Web, :view

  def render("index.json", %{classes: classes}) do
    %{data: render_many(classes, "class.json")}
  end

  def render("show.json", %{class: class}) do
    %{data: render_one(class, "class.json")}
  end

  def render("class.json", %{class: class}) do
    %{id: class.id, name: class.name}
  end
end
