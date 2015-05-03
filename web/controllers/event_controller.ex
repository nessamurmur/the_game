defmodule TheGame.EventController do
  use TheGame.Web, :controller

  alias TheGame.Event

  plug :scrub_params, "event" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    events = Repo.all(Event)
    render(conn, "index.json", events: events)
  end

  def create(conn, %{"event" => event_params}) do
    changeset = Event.changeset(%Event{}, event_params)

    if changeset.valid? do
      event = Repo.insert(changeset)
      render(conn, "show.json", event: event)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(TheGame.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Repo.get(Event, id)
    render conn, "show.json", event: event
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Repo.get(Event, id)
    changeset = Event.changeset(event, event_params)

    if changeset.valid? do
      event = Repo.update(changeset)
      render(conn, "show.json", event: event)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(TheGame.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Repo.get(Event, id)

    event = Repo.delete(event)
    render(conn, "show.json", event: event)
  end
end
