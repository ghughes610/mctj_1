defmodule Mctj.Workouts.Workout do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workouts" do
    field :name, :string
    field :type, :string
    field :user_id, :integer
    field :metadata, :map

    embeds_one :layout, Layout do
      field :circuits, {:array, :map}, default: []
    end

    timestamps()
  end

  def changeset(workout, attrs) do
    workout
    |> cast(attrs, [:name, :type, :metadata, :user_id])
    |> cast_embed(:layout, required: true, with: &layout_changeset/2)
  end

  def layout_changeset(layout, attrs \\ %{}) do
    layout
    |> cast(attrs, [:circuits])
  end
end
