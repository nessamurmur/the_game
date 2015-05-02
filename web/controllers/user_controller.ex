defmodule TheGame.UserController do
  use TheGame.Web, :controller

  alias TheGame.User

  plug :scrub_params, "user" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    if changeset.valid? do
      user = Repo.insert(changeset)
      render(conn, "show.json", user: user)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(TheGame.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.one(from(u in User, where: u.key == ^id))
    render conn, "show.json", user: user
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user, user_params)

    if changeset.valid? do
      user = Repo.update(changeset)
      render(conn, "show.json", user: user)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(TheGame.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get(User, id)

    user = Repo.delete(user)
    render(conn, "show.json", user: user)
  end
end
