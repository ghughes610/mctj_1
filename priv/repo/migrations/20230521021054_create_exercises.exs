defmodule Mctj.Repo.Migrations.CreateExercises do
  use Ecto.Migration

  def change do
    create table(:exercises) do
      add :name, :string
      add :reps, :string
      add :weight, :string
      add :metadata, :map
      add :workout_id, :integer

      timestamps()
    end
  end
end
