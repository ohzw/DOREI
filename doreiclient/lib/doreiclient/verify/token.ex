defmodule Doreiclient.Verify.Token do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tokens" do
    field :groupid, :integer
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(token, attrs) do
    token
    |> cast(attrs, [:groupid, :token])
    |> validate_required([:groupid, :token])
  end
end
