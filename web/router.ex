defmodule TheGame.Router do
  use TheGame.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TheGame do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", TheGame do
    pipe_through :api
    resources "/characters", CharacterController
    resources "/classes", ClassController
  end
end
