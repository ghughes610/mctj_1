defmodule Mctj.Workouts.Workout do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workouts" do
    field :name, :string
    field :type, :string
    field :user_id, :integer
    field :metadata, :map

    embeds_one :circuits, Circuit do
      field :sets, :integer, default: 3
      field :rest_time, :integer, default: 90
      field :exercises, {:array, :map}, default: [
        %{
          name: "Pushups",
          reps: 10,
          weight: 0,
          rest_time: 0
        },
        %{
          name: "Pullups",
          reps: 10,
          weight: 0,
          rest_time: 0
        },
        %{
          name: "Squats",
          reps: 10,
          weight: 0,
          rest_time: 0
        }
      ]
    end


    timestamps()
  end

  def changeset(workout, attrs) do
    workout
    |> cast(attrs, [:name, :type, :metadata, :user_id])
    |> cast_embed(:circuits, required: true, with: &circuit_changeset/2)
  end

  def circuit_changeset(circuit, attrs \\ %{}) do
    circuit
    |> cast(attrs, [:sets, :rest_time])
  end
end

# Workout.changeset(%Workout{},%{circuit: %{sets: 3, rest_time: 60}})
