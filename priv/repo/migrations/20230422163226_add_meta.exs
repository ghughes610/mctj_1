defmodule Mctj.Repo.Migrations.AddMeta do
  use Ecto.Migration

  def change do
    alter table(:climbs) do
      add(:metadata, :map, default: %{})
    end
  end
end
