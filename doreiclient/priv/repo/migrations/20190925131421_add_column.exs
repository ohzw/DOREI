defmodule Doreiclient.Repo.Migrations.AddColumn do
  use Ecto.Migration

  def change do
    alter table( :tasks ) do
      add :is_accomplished, :boolean
    end
  end
end
