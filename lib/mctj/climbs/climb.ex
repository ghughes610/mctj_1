defmodule Mctj.Climbs.Climb do
  use Ecto.Schema
  import Ecto.Changeset

  schema "climbs" do
    field :bolt_count, :integer
    field :grade, :string
    field :height, :integer
    field :name, :string
    field :metadata, :map, default: %{}
    field :wall_id, :id

    timestamps()
  end

  @doc false
  def changeset(climb, attrs) do
    climb
    |> cast(attrs, [:name, :bolt_count, :grade, :height, :wall_id, :metadata])
    |> validate_required([:name, :grade])
  end
end
