defmodule Doreiclient.Repo.Migrations.AddDeadlineToTasks do
  use Ecto.Migration

  def change do
    alter table( :tasks ) do
      add :dead_line, :naive_datetime
    end
  end
end