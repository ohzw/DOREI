defmodule DoreiclientWeb.TaskController do
  use DoreiclientWeb, :controller
  use Timex

  alias Doreiclient.Tasks
  alias Doreiclient.Tasks.Task

  action_fallback DoreiclientWeb.FallbackController

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => task_params}) do
    with {:ok, %Task{} = task} <- Tasks.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.task_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    with {:ok, %Task{} = task} <- Tasks.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)

    with {:ok, %Task{}} <- Tasks.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_task_data(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def accomp(conn, %{"task" => name,"groupid" => id}) do
    Tasks.accomplish(name,id)
    json(conn, %{message: "Task has been accomplished!"})
  end

  def set_deadline(conn,%{"task" => id,"year" => year,"month" => month,"day" => day,"hour" => hour,"minute" => minute,"second" => second}) do
    time =
      NaiveDateTime.new(year,month,day,hour,minute,second)
      |>elem(1)
    Tasks.updateDeadline(id,time)
    json(conn, %{message: "Deadline has been updated!"})
  end

  def time_difference(conn, %{"id" => id}) do
    time = Tasks.compare_time(id)
      day = div(time, 86400)
      hour = div(rem(time, 86400), 3600)
      minute = div(rem(time, 3600), 60)
    json(conn, %{day: day, hour: hour})
  end

  def changeworker(conn, %{"newWorker" => newWorker, "id" => id}) do
    Tasks.updateWorker(newWorker,id)
    json(conn, %{message: "Worker has been updated!"})
  end

end
