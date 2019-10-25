defmodule Doreiclient.Repo.Migrations.CreateGroupWorkers do
  use Ecto.Migration

  def change do
    create table(:group_workers) do
      add :role, :string
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :group_id, references(:groups, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:group_workers, [:user_id])
    create index(:group_workers, [:group_id])
  end
end
