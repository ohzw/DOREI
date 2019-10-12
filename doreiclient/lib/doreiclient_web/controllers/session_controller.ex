defmodule DoreiclientWeb.SessionController do
  use DoreiclientWeb, :controller
  alias Doreiclient.Accounts
  alias Doreiclient.Accounts.User
  alias Doreiclient.Accounts.Guardian

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
  end

  def create(conn, %{"userid" => userid, "password" => password}) do
    Accounts.authenticate_user(userid, password)
    |> login_reply(conn)
  end

  defp login_reply({:error, error}, conn) do
    conn
    |> json(%{error: error})
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> json(%{message: "Logged in."})
    |> Guardian.Plug.sign_in(user)
  end

  def delete(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> json(%{message: "Logout."})
  end
end