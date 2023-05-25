defmodule Mctj.Workouts.Workout do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workouts" do
    field :name, :string
    field :type, :string
    field :user_id, :integer
    field :metadata, :map
    field :sets, :integer
    field :number_of_circuits, :integer

    timestamps()

    has_many :exercises, Mctj.Exercises.Exercise
  end

  def changeset(workout, attrs) do
    workout
    |> cast(attrs, [:name, :type, :metadata, :user_id, :number_of_circuits, :sets])
  end
end
