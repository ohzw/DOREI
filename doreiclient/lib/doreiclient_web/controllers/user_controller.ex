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

  def create(conn, %{"userid" => userid, "name" => name, "password" => password}) do
    user = %{userid: userid, name: name, password: password}
    with {:ok, %User{} = user} <- Accounts.create_user(user) do
      conn
      |> json(%{message: "user has been created!"})
      |> Guardian.Plug.sign_in(user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def edit(conn, _) do
    changeset = Accounts.change_user(conn.assigns.current_user)
  end

  def update(conn, %{"user" => user_params}) do
    user = conn.assigns.current_user
    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, _) do
    {:ok, _user} = Accounts.delete_user(conn.assigns.current_user)
    conn
    |> Guardian.Plug.sign_out()
    |> json(%{message: "user has been deleted."})
  end

  defp is_authorized(conn, _) do
    current_user = Accounts.current_user(conn)
      if current_user.id == String.to_integer(conn.params["id"]) do
        assign(conn, :current_user, current_user)
      else
        conn
        |> json(%{message: "You can't modify."})
        |> halt()
      end
  end
  def test(conn, _) do
    who = Accounts.current_user(conn)
    json(conn, %{who: who})
  end
end
