defmodule Mctj.Repo.Migrations.CreateAreas do
  use Ecto.Migration

  def change do
    create table(:areas) do
      add :name, :string
      add :location, :string
      add :sun_exposure, :string
      add :hike_time, :integer
      add :metadata, :map, default: %{}

      timestamps()
    end
  end
end
