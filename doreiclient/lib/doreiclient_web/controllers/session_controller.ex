defmodule DoreiclientWeb.SessionController do
  use DoreiclientWeb, :controller
  alias Doreiclient.Accounts
  alias Doreiclient.Accounts.User
  alias Doreiclient.Accounts.Guardian

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
  end

  def create(conn, %{"user" => %{"userid" => userid, "password" => password}}) do
    Accounts.authenticate_user(userid, password)
    |> login_reply(conn)
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> Guardian.Plug.sign_in(user)
    |> json(%{message: "logged in!"})
  end

  defp login_reply({:error, error}, conn) do
    conn
    |>json(%{error: error})
  end

  def delete(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> json(%{message: "Logout successfully."})
  end
end