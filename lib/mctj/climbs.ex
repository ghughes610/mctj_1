defmodule Mctj.Climbs do
  import Ecto.Query, warn: false
  alias Mctj.Repo

  alias Mctj.Climbs.Climb

  def list_climbs, do: Repo.all(Climb)

  def get_climb!(id), do: Repo.get!(Climb, id)

  def get_climb_by_name!(name) do
    Repo.one!(from c in Climb, where: c.name == ^name)
  end

  def get_climbs_by_grade(grade) do
    Repo.all(from c in Climb, where: c.grade == ^grade)
  end

  def batch_insert_climbs(climbs) do
    Repo.insert_all(Climb, climbs)
  end

  def create_climb(attrs \\ %{}) do
    %Climb{}
    |> Climb.changeset(attrs)
    |> Repo.insert()
  end

  def update_climb(%Climb{} = climb, attrs) do
    climb
    |> Climb.changeset(attrs)
    |> Repo.update()
  end

  def delete_climb(%Climb{} = climb) do
    Repo.delete(climb)
  end
end
