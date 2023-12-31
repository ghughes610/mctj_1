defmodule Mctj.Repo.Migrations.CreateFingerLogs do
  use Ecto.Migration

  def change do
    create table(:finger_logs) do
      add :exercise, :string
      add :position, :string
      add :average_left_hand_pull, :integer
      add :average_right_hand_pull, :integer
      add :max_left_hand_pull, :integer
      add :max_right_hand_pull, :integer
      add :time_on, :integer
      add :time_off, :integer
      add :reps, :integer
      add :set, :integer
      add :rest_time, :integer
      add :edge_size, :string
      add :workout_id, references(:workouts, on_delete: :nothing)

      timestamps()
    end

    create index(:finger_logs, [:workout_id])
  end
end
