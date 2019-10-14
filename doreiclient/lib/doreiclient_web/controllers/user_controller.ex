defmodule DoreiclientWeb.UserController do
  use DoreiclientWeb, :controller

  alias Doreiclient.Accounts
  alias Doreiclient.Accounts.User
  alias Doreiclient.Accounts.Guardian

  plug :is_authorized when action in [:edit, :update, :delete]

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
      |> Guardian.Plug.sign_in(user)
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, _) do
    {:ok, _user} = Accounts.delete_user(conn.assigns.current_user)
    conn
    |> Guardian.Plug.sign_out()
    |> json(%{message: "User deleted successfully."})
    # |> send_resp(:no_content, "")
  end

  defp is_authorized(conn, _) do
    current_user = Accounts.current_user(conn)
      if current_user.id == String.to_integer(conn.params["id"]) do
        assign(conn, :current_user, current_user)
      else
        conn
        |> json(%{error: "You can't modify."})
        |> halt()
      end
  end

  def test(conn, _) do
    current_user = Accounts.current_user(conn)
    conn
    |> json(%{msg: current_user})
  end
end
