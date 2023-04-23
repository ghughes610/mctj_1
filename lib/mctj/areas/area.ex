defmodule Mctj.Areas.Area do
  use Ecto.Schema
  import Ecto.Changeset

  schema "areas" do
    field :hike_time, :integer
    field :location, :string
    field :name, :string
    field :sun_exposure, :string
    field :metadata, :map, default: %{}

    timestamps()
  end

  @doc false
  def changeset(area, attrs) do
    area
    |> cast(attrs, [:name, :location, :sun_exposure, :hike_time, :metadata])
    |> validate_required([:name])
  end
end
