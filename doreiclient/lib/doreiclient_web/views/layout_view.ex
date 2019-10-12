defmodule DoreiclientWeb.LayoutView do
  use DoreiclientWeb, :view
  alias Doreiclient.Accounts.Guardian
  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end
end
