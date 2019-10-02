defmodule Doreiclient.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :leader, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :leader])
    |> validate_required([:name, :leader])
  end
end
