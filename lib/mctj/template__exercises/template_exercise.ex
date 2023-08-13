defmodule Mctj.Template_Exercises.Template_exercise do
  use Ecto.Schema
  import Ecto.Changeset

  schema "template_exercises" do
    field :is_fingers, :boolean, default: false
    field :metadata, :map
    field :movement, :string
    field :name, :string
    field :plane, :string
    field :reps, :integer
    field :time, :string
    field :weight, :string

    timestamps()
  end

  @doc false
  def changeset(template_exercise, attrs) do
    template_exercise
    |> cast(attrs, [:name, :weight, :plane, :movement, :reps, :metadata, :is_fingers, :time])
    |> validate_required([:name, :weight, :plane, :movement, :reps, :metadata, :is_fingers, :time])
  end
end
