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
    get "/userdata", UserController, :get_current_userdata
    get "/current_userid", UserController, :get_current_userid #テスト用
    resources "/users", UserController, except: [:new, :edit] # post: ユーザー追加
    delete "/deleteacc", UserController, :delete

    resources "/tasks", TaskController, except: [:new, :edit]
    post "/accomp", TaskController, :accomp
    get "/taskdata", TaskController, :get_task_data
    get "/taskdata/timedifference", TaskController, :time_difference
    post "/changeworker", TaskController, :changeworker
    post "/setdeadline", TaskController, :set_deadline

    resources "/groups", GroupController, except: [:new, :edit]
    post "/addworker", GroupController, :add_worker
    post "/search_user_from_group", GroupController, :search_user_from_group #テスト用
    # post "/create_grouptask", GroupController, :create_group_task
    post "/set_role", GroupController, :set_role
  end

  # Other scopes may use custom stacks.
  # scope "/api", DoreiclientWeb do
  #   pipe_through :api
  # end
end
