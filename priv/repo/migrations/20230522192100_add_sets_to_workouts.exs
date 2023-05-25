defmodule Mctj.Repo.Migrations.AddSetsToWorkouts do
  use Ecto.Migration

  def change do
    alter table(:workouts) do
      add :sets, :integer
      add :number_of_circuits, :integer
    end
  end
end
