defmodule Mctj.Repo.Migrations.AddMetaToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :metadata, :map, default: %{}
    end
  end
end
