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

    post "/signin", UserController, :create
    post "/login", SessionController, :login
    post "/logout", SessionController, :logout
    post "/refresh_token", SessionController, :refresh_token
    get "/", PageController, :index
  end

  scope "/", DoreiclientWeb do
    pipe_through [:api, :auth, :ensure_auth]

    resources "/users", UserController, except: [:new, :edit] # post: ユーザー追加
    get "/current_userid", UserController, :get_current_userid

    resources "/tasks", TaskController, except: [:new, :edit]
    post "/accomp", TaskController, :accomp
    post "/setdeadline", TaskController, :set_deadline
    get "/timedifference", TaskController, :time_difference
    post "/changeworker", TaskController, :changeworker

    resources "/groups", GroupController, except: [:new, :edit]
    post "/addworker", GroupController, :add_worker
    post "/deletegroup", GroupController, :delete
    # post "/group/taskcreate", GroupController, :group_task_create
  end

  # Other scopes may use custom stacks.
  # scope "/api", DoreiclientWeb do
  #   pipe_through :api
  # end
end
