defmodule Doreiclient.GroupWorkers.GroupWorker do
  use Ecto.Schema
  import Ecto.Changeset
  alias Doreiclient.Groups.Group
  alias Doreiclient.Accounts.User
  schema "group_workers" do
    belongs_to :group, Group
    belongs_to :user, User
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(group_worker, attrs) do
    group_worker
    |> cast(attrs, [:role, :user_id, :group_id])
    |> validate_required([:role, :user_id, :group_id])
  end
end
