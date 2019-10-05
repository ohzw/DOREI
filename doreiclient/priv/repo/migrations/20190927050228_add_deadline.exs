defmodule Doreiclient.Repo.Migrations.AddDeadline do
  use Ecto.Migration

  def change do
    alter table( :tasks ) do
      add :dead_line, :naive_datetime
      add :accomplished_at, :naive_datetime
      add :preference, :integer
    end
  end
end
