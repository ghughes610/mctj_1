defmodule Mctj.Repo.Migrations.CreateClimbs do
  use Ecto.Migration

  def change do
    create table(:climbs) do
      add :name, :string
      add :bolt_count, :integer
      add :grade, :string
      add :height, :integer
      add :area_id, references(:areas, on_delete: :delete_all)

      timestamps()
    end
  end
end
