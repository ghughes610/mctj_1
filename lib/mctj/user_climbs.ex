defmodule Mctj.UserClimbs do
  import Ecto.Query, warn: false
  alias Mctj.Repo

  alias Mctj.UserClimbs.UserClimb

  def list_user_climbs(user_id) do
    UserClimb
    |> where(user_id: ^user_id)
    |> Repo.all()
  end

  def get_user_climb!(id), do: Repo.get!(UserClimb, id)

  def create_user_climb(attrs \\ %{}) do
    %UserClimb{}
    |> UserClimb.changeset(attrs)
    |> Repo.insert()
  end

  def update_user_climb(%UserClimb{} = user_climb, attrs) do
    user_climb
    |> UserClimb.changeset(attrs)
    |> Repo.update()
  end

  def delete_user_climb(%UserClimb{} = user_climb) do
    Repo.delete(user_climb)
  end

  def change_user_climb(%UserClimb{} = user_climb, attrs \\ %{}) do
    UserClimb.changeset(user_climb, attrs)
  end
end
