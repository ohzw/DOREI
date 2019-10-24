defmodule DoreiclientWeb.UserController do
  use DoreiclientWeb, :controller

  alias Doreiclient.Accounts
  alias Doreiclient.Accounts.User
  alias Doreiclient.Accounts.Guardian

  action_fallback DoreiclientWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    current_user = Accounts.current_user(conn)
    user = Accounts.get_user!(id)
    if current_user.id == user.id do
      Accounts.update_user(user, user_params)
      render(conn, "show.json", user: user)
    else
      conn
      |> json%{message: "auth error."}
    end
  end

  def delete(conn, %{"id" => id}) do
    current_user = Accounts.current_user(conn)
    user = Accounts.get_user!(id)
    if current_user.id == user.id do
      Accounts.delete_user(user)
      conn
      |> json(%{message: "User deleted."})
    else
      conn
      |> json(%{message: "You can't modify"})
    end
  end

  def get_current_userid(conn, _) do
    current_user = Accounts.current_user(conn)
    conn |> json(%{message: current_user.id})
  end

end
