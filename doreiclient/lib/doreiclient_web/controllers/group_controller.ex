defmodule DoreiclientWeb.GroupController do
  use DoreiclientWeb, :controller

  alias Doreiclient.Groups
  alias Doreiclient.Groups.Group
  alias Doreiclient.Tasks
  alias Doreiclient.Accounts

  action_fallback DoreiclientWeb.FallbackController

  def index(conn, _params) do
    groups = Groups.list_groups()
    render(conn, "groups.json", groups: groups)
  end

  def create(conn, %{"group" => group_params}) do
    user_id = Accounts.current_user(conn).id
    with {:ok, %Group{} = group} <- Groups.create_group(group_params) do
      group_id = Groups.get_group!(conn).id
      conn
      |> Groups.add_to_workers(user_id, group_id)
      |> render("show.json", group: group)
      # |> json(%{msg: "Group created!"})
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

  def delete(conn, %{"id" => id}) do #要修正 リーダーかどうか確認する
    group = Groups.get_group!(id)
    with {:ok, %Group{}} <- Groups.delete_group(group) do
      json(conn, %{msg: "group deleted."})
    end
  end

  def add_worker(conn, %{"groupid"=> id, "workerid" => worker}) do
    group = Groups.get_group!(id).workers
    conn
    |> add_worker_to_group(Groups.is_in_group(group, worker))
  end
  defp add_worker_to_group(conn, {:ok, worker}) do
    json(conn, %{msg: "already in"})
  end
  defp add_worker_to_group(conn, {:no, worker}) do
    json(conn, %{msg: "ok worker"})
  end
#   #実行したユーザーがgroupidのグループ内にいるか確認する
#   def group_task_create(conn, %{"task" => task_params, "groupid" => groupid}) do
#     with {:ok, %Task{} = task} <- Tasks.create_task(task_params) do
#       Groups.add_to_group(groupid)
#       # conn
#       # |> put_status(:created)
#       # |> render("show.json", task: task)
#     end
#   end

#   defp add_to_group(conn,) do

#   end


end