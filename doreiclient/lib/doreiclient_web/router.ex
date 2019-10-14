defmodule DoreiclientWeb.Router do
  use DoreiclientWeb, :router
  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Doreiclient.Accounts.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", DoreiclientWeb do
    pipe_through [:api, :auth]
    # get "/", PageController, :index
    get "/signin", UserController, :new
    post "/signin", UserController, :create
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  scope "/", DoreiclientWeb do
    pipe_through [:api, :auth, :ensure_auth]
    resources "/users", UserController, except: [:new, :edit] # post: ユーザー追加
    resources "/tasks", TaskController, except: [:new, :edit]
    post "/accomp", TaskController, :accomp
    post "/changeworker", TaskController, :changeworker
    get "/taskdata", TaskController, :get_task_data
    get "/taskdata/timedifference", TaskController, :time_difference
    post "/setdeadline", TaskController, :set_deadline
    get "/test", UserController, :test
  end

  # Other scopes may use custom stacks.
  # scope "/api", DoreiclientWeb do
  #   pipe_through :api
  # end
end
