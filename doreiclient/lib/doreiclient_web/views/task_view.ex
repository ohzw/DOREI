defmodule DoreiclientWeb.TaskView do
  use DoreiclientWeb, :view
  alias DoreiclientWeb.TaskView

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{id: task.id,
      task: task.task,
      groupid: task.groupid,
      order: task.order,
      worker: task.worker}
  end
end
