defmodule DoreiclientWeb.UserView do
  use DoreiclientWeb, :view
  alias DoreiclientWeb.UserView
  alias Doreiclient.Accounts

  def current_user(conn) do
    Accounts.current_user(conn)
  end

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      userid: user.userid,
      name: user.name,
      password: user.password}
  end
end
