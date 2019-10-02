defmodule Doreiclient.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :groupid, :integer
    field :order, :string
    field :task, :string
    field :worker, :string
    field :deadline, :naive_datetime
    field :is_accomplished, :boolean
    field :preference, :integer
    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:task, :groupid, :order, :worker])
    |> validate_required([:task, :groupid, :order, :worker])
  end
end
