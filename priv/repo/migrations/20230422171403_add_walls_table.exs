defmodule Mctj.Repo.Migrations.AddWallsTable do
  use Ecto.Migration

  def change do
    create table(:walls) do
      add :name, :string
      add :sun_exposure, :string
      add :hike_time, :integer
      add :area_id, references(:areas, on_delete: :delete_all)

      timestamps()
    end

    alter table(:areas) do
      remove :sun_exposure
      remove :hike_time
    end

    alter table(:climbs) do
      remove :area_id
      add :wall_id, references(:walls, on_delete: :delete_all)
    end
  end
end
