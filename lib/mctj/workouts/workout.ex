defmodule Mctj.Workouts.Workout do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workouts" do
    field :name, :string
    field :type, :string
    field :user_id, :integer
    field :metadata, :map

    timestamps()

    has_many :exercise,  Mctj.Exercises.Exercise
  end

  def changeset(workout, attrs) do
    workout
    |> cast(attrs, [:name, :type, :metadata, :user_id])
  end
end
