defmodule Doreiclient.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :groupid, :integer
    field :order, :string
    field :task, :string
    field :worker, :string
    field :is_accomplished, :boolean
    field :preference, :integer
    field :accomplished_at, :naive_datetime
    field :dead_line, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:task, :order, :worker])
    |> validate_required([:task, :order, :worker])
  end
end
