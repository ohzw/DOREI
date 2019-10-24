defmodule Doreiclient.Repo.Migrations.CreateGroupWorkers do
  use Ecto.Migration

  def change do
    create table(:group_workers) do
      add :user_id, references(:users, on_delete: :nothing)
      add :group_id, references(:groups, on_delete: :nothing)
      add :role, :string

      timestamps()
    end

    create index(:group_workers, [:user_id])
    create index(:group_workers, [:group_id])
  end
end
