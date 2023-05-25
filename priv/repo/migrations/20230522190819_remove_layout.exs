defmodule Mctj.Repo.Migrations.RemoveLayout do
  use Ecto.Migration

  def change do
    alter table(:workouts) do
      remove :layout
    end
  end
end
