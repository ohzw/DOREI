defmodule Doreiclient.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset
  alias Doreiclient.GroupWorkers.GroupWorker

  schema "groups" do
    field :name, :string
    field :description, :string

    has_many :group_workers, GroupWorker
    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
