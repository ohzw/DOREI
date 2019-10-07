defmodule Doreiclient.Tasks do
  @moduledoc """
  The Tasks context.
  """
  use Timex
  import Ecto.Query, warn: false
  alias Doreiclient.Repo

  alias Doreiclient.Tasks.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id), do: Repo.get!(Task, id)

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    val = Map.put(attrs, :is_accomplished, false)
    %Task{}
    |> Task.changeset(val)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end

  def accomplish(task,id) do
    accomplished_at = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
    from(p in Task, where: p.task == ^task and p.groupid == ^id)
    |> Repo.update_all(set: [is_accomplished: true, accomplished_at: accomplished_at])
  end

  def updateWorker(newWorker,id) do
    from(p in Task, where: p.id == ^id)
    |> Repo.update_all(set: [worker: newWorker])
  end

  def updateDeadline(id,time) do
    from(p in Task, where: p.id == ^id)
    |> Repo.update_all(set: [dead_line: time])
  end

  def compare_time(id) do
    dead_line = Repo.get!(Task, id).dead_line
    accomplished_at =  Repo.get!(Task, id).accomplished_at
    NaiveDateTime.diff(dead_line,accomplished_at)
  end

  def set_preference(id,preference) do
    from(p in Task, where: p.id == ^id)
    |> Repo.update_all(set: [preference: preference])
  end
end