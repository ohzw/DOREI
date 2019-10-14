defmodule DoreiclientWeb.SessionView do
  use DoreiclientWeb, :view
  alias Doreiclient.Accounts
  def current_user(conn) do
    Accounts.current_user(conn)
  end
end