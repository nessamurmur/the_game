defmodule TheGame.CharacterController do
  use TheGame.Web, :controller

  alias TheGame.Character
  alias TheGame.User
  
  plug :scrub_params, "character" when action in [:create, :update]
  plug :action

  def index(conn, %{"user_id" => user_key}) do
    user = Repo.one(from u in User, where: u.key == ^user_key)
    characters = Repo.all(from c in Character, where: c.user_id == ^user.id)
    render(conn, "index.json", characters: characters)
  end

  def create(conn, %{"user_id" => user_key, "character" => character_params}) do
    user = Repo.one(from u in User, where: u.key == ^user_key)
    changeset = Character.changeset(%Character{},
                                    Map.merge(character_params, %{"user_id" => user.id}))

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
    user = Repo.one(from u in User, where: u.key == ^user_key)
    character = Repo.one(from c in Character, where: c.user_id == ^user.id, where: c.id == ^id)
    render conn, "show.json", character: character
  end

  def update(conn, %{"user_id" => user_key, "id" => id, "character" => character_params}) do
    user = Repo.one(from u in User, where: u.key == ^user_key)
    character = Repo.one(from c in Character, where: c.user_id == ^user.id, where: c.id == ^id)
    changeset = Character.changeset(character, character_params)

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
    user = Repo.one(from u in User, where: u.key == ^user_key)
    character = Repo.one(from c in Character, where: c.user_id == ^user.id, where: c.id == ^id)

    character = Repo.delete(character)
    render(conn, "show.json", character: character)
  end
end
