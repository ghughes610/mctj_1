defmodule Mctj.Repo.Migrations.AddZipToClimbs do
  use Ecto.Migration

  def change do
    alter table(:climbs) do
      add :zip, :integer
    end
  end
end
