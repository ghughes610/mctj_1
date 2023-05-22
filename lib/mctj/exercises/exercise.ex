defmodule Mctj.Exercises.Exercise do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exercises" do
    field :metadata, :map
    field :name, :string
    field :reps, :string
    field :weight, :string

    timestamps()

    belongs_to :workout, Mctj.Workouts.Workout
  end

  @doc false
  def changeset(exercise, attrs) do
    exercise
    |> cast(attrs, [:name, :reps, :weight, :metadata, :workout_id])
    |> validate_required([:name, :reps, :weight, :metadata, :workout_id])
  end
end
