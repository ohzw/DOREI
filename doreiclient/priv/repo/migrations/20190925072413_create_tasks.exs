defmodule Doreiclient.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :task, :string, null: false
      add :groupid, :integer
      add :order, :string
      add :worker, :string, null: false

      timestamps()
    end

  end
end
