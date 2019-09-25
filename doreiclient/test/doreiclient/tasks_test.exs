defmodule Doreiclient.TasksTest do
  use Doreiclient.DataCase

  alias Doreiclient.Tasks

  describe "tasks" do
    alias Doreiclient.Tasks.Task

    @valid_attrs %{groupid: 42, order: "some order", task: "some task", worker: "some worker"}
    @update_attrs %{groupid: 43, order: "some updated order", task: "some updated task", worker: "some updated worker"}
    @invalid_attrs %{groupid: nil, order: nil, task: nil, worker: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tasks.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Tasks.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Tasks.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Tasks.create_task(@valid_attrs)
      assert task.groupid == 42
      assert task.order == "some order"
      assert task.task == "some task"
      assert task.worker == "some worker"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, %Task{} = task} = Tasks.update_task(task, @update_attrs)
      assert task.groupid == 43
      assert task.order == "some updated order"
      assert task.task == "some updated task"
      assert task.worker == "some updated worker"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Tasks.update_task(task, @invalid_attrs)
      assert task == Tasks.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Tasks.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Tasks.change_task(task)
    end
  end
end
