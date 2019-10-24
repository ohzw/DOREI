defmodule Doreiclient.Groups.GroupWorker do
  use Ecto.Schema
  import Ecto.Changeset

  schema "group_workers" do
    field :role, :string
    field :user_id, :id
    field :group_id, :id

    timestamps()
  end

  @doc false
  def changeset(group_worker, attrs) do
    group_worker
    |> cast(attrs, [:user_id, :group_id])
    |> validate_required([:user_id, :group_id])
  end
end
