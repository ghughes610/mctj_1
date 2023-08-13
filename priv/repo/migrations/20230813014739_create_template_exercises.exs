defmodule Mctj.Repo.Migrations.CreateTemplateExercises do
  use Ecto.Migration

  def change do
    create table(:template_exercises) do
      add :name, :string
      add :weight, :string
      add :plane, :string
      add :movement, :string
      add :reps, :integer
      add :metadata, :map
      add :is_fingers, :boolean, default: false, null: false
      add :time, :string

      timestamps()
    end
  end
end
