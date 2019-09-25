defmodule DoreiclientWeb.Router do
  use DoreiclientWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DoreiclientWeb do
    pipe_through :browser
    resources "/users", UserController, except: [:new, :edit]
    resources "/tasks", TaskController, except: [:new, :edit]
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", DoreiclientWeb do
  #   pipe_through :api
  # end
end
