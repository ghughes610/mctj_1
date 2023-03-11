defmodule Mctj.Repo.Migrations.CreateWorkouts do
  use Ecto.Migration

  def change do
    create table(:workouts) do
      add :name, :string
      add :type, :string

      timestamps()
    end
  end
end
