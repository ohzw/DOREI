defmodule Doreiclient.Repo.Migrations.CreateTokens do
  use Ecto.Migration

  def change do
    create table(:tokens) do
      add :groupid, :integer
      add :token, :string

      timestamps()
    end

  end
end
