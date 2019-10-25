defmodule DoreiclientWeb.GroupController do
  use DoreiclientWeb, :controller

  alias Doreiclient.Groups
  alias Doreiclient.Groups.Group
  alias Doreiclient.Accounts
  alias Doreiclient.Tasks

  action_fallback DoreiclientWeb.FallbackController

  def index(conn, _params) do
    groups = Groups.list_groups()
    render(conn, "index.json", groups: groups)
  end

  def create(conn, %{"group" => group_params}) do
    user = Accounts.current_user(conn)
    with {:ok, %Group{} = group} <- Groups.create_group(group_params) do
      val = Map.new(user_id: user.id, group_id: group.id, role: "leader")
      Groups.create_group_worker(val)

      conn |> render("show.json", group: group)
    end
  end

  def show(conn, %{"id" => id}) do
    group = Groups.get_group!(id)
    render(conn, "show.json", group: group)
  end

  def update(conn, %{"id" => id, "group" => group_params}) do
    group = Groups.get_group!(id)

    with {:ok, %Group{} = group} <- Groups.update_group(group, group_params) do
      render(conn, "show.json", group: group)
    end
  end

  def delete(conn, %{"id" => id}) do
    group = Groups.get_group!(id)

    with {:ok, %Group{}} <- Groups.delete_group(group) do
      send_resp(conn, :no_content, "")
    end
  end
end
