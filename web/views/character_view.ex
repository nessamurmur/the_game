defmodule TheGame.CharacterView do
  use TheGame.Web, :view

  def render("index.json", %{characters: characters}) do
    %{data: render_many(characters, "character.json")}
  end

  def render("show.json", %{character: character}) do
    %{data: render_one(character, "character.json")}
  end

  def render("character.json", %{character: character}) do
    %{id: character.id}
  end
end
