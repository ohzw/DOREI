defmodule DoreiclientWeb.Router do
  use DoreiclientWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DoreiclientWeb do
    pipe_through :api

    post "/signin", UserController, :create
    post "/deleteacc", UserController, :delet
    post "/login", SessionController, :login
    post "/logout", SessionController, :logout
    post "/refresh_token", SessionController, :refresh_token

    get "/", PageController, :index
    resources "/users", UserController, except: [:new, :edit] # post: ユーザー追加

    resources "/tasks", TaskController, except: [:new, :edit]
    get "/taskdata", TaskController, :get_task_data
    get "/taskdata/timedifference", TaskController, :time_difference
    post "/changeworker", TaskController, :changeworker
    post "/setdeadline", TaskController, :set_deadline
    post "/accomp", TaskController, :accomp
  end

  # Other scopes may use custom stacks.
  # scope "/api", DoreiclientWeb do
  #   pipe_through :api
  # end
end
