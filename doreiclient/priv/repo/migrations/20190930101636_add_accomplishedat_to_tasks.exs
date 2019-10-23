defmodule Doreiclient.Repo.Migrations.AddAccomplishedatToTasks do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :accomplished_at, :timestamp
    end
  end
end
