defmodule TheGame.CharacterController do
  use TheGame.Web, :controller

  alias TheGame.Character
  alias TheGame.User

  plug :scrub_params, "character" when action in [:create, :update]
  plug :get_user
  plug :get_character when action in [:edit, :show, :update, :delete]
  plug :action

  def index(conn, _) do
    characters = Repo.all(from c in Character, where: c.user_id == ^conn.assigns.user.id)
    render(conn, "index.json", characters: characters)
  end

  def create(conn, %{"user_id" => user_key, "character" => character_params}) do
    changeset = Character.changeset(%Character{},
                                    Map.merge(character_params, %{"user_id" => conn.assigns.user.id}))

    if changeset.valid? do
      character = Repo.insert(changeset)
      render(conn, "show.json", character: character)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(TheGame.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"user_id" => user_key, "id" => id}) do
    render conn, "show.json", character: conn.assigns.character
  end

  def update(conn, %{"user_id" => user_key, "id" => id, "character" => character_params}) do
    changeset = Character.changeset(conn.assigns.character, character_params)

    if changeset.valid? do
      character = Repo.update(changeset)
      render(conn, "show.json", character: character)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(TheGame.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"user_id" => user_key, "id" => id}) do
    character = Repo.delete(conn.assigns.character)
    render(conn, "show.json", character: character)
  end

  defp get_user(conn, _) do
    user = Repo.one(from u in User, where: u.key == ^conn.params["user_id"])
    assign(conn, :user, user)
  end

  defp get_character(conn, _) do
    character = Repo.one(from c in Character, where: c.user_id == ^conn.assigns.user.id, where: c.id == ^conn.params["id"])
    assign(conn, :character, character)
  end
end
