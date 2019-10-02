defmodule DoreiclientWeb.Router do
  use DoreiclientWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DoreiclientWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit] # post: ユーザー追加
    resources "/tasks", TaskController, except: [:new, :edit]
    get "/", PageController, :index
    post "/accomp", TaskController, :accomp
    post "/changeworker", TaskController, :changeworker
    get "/taskdata", TaskController, :get_task_data
  end

  # Other scopes may use custom stacks.
  # scope "/api", DoreiclientWeb do
  #   pipe_through :api
  # end
end
