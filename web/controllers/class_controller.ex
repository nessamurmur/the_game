defmodule TheGame.ClassController do
  use TheGame.Web, :controller

  alias TheGame.Class

  plug :scrub_params, "class" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    classes = Repo.all(Class)
    render(conn, "index.json", classes: classes)
  end

  def create(conn, %{"class" => class_params}) do
    changeset = Class.changeset(%Class{}, class_params)

    if changeset.valid? do
      class = Repo.insert(changeset)
      render(conn, "show.json", class: class)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(TheGame.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    class = Repo.get(Class, id)
    render conn, "show.json", class: class
  end

  def update(conn, %{"id" => id, "class" => class_params}) do
    class = Repo.get(Class, id)
    changeset = Class.changeset(class, class_params)

    if changeset.valid? do
      class = Repo.update(changeset)
      render(conn, "show.json", class: class)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(TheGame.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    class = Repo.get(Class, id)

    class = Repo.delete(class)
    render(conn, "show.json", class: class)
  end
end
