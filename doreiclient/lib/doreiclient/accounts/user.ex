defmodule Doreiclient.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :password, :string
    field :userid, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:userid, :name, :password])
    |> validate_required([:userid, :name, :password])
    |> unique_constraint(:userid)
  end
end
