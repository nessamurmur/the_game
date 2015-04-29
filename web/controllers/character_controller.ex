defmodule TheGame.CharacterController do
  use TheGame.Web, :controller

  alias TheGame.Character

  plug :scrub_params, "character" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    characters = Repo.all(Character)
    render(conn, "index.json", characters: characters)
  end

  def create(conn, %{"character" => character_params}) do
    changeset = Character.changeset(%Character{}, character_params)

    if changeset.valid? do
      character = Repo.insert(changeset)
      render(conn, "show.json", character: character)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(TheGame.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    character = Repo.get(Character, id)
    render conn, "show.json", character: character
  end

  def update(conn, %{"id" => id, "character" => character_params}) do
    character = Repo.get(Character, id)
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

  def delete(conn, %{"id" => id}) do
    character = Repo.get(Character, id)

    character = Repo.delete(character)
    render(conn, "show.json", character: character)
  end
end
