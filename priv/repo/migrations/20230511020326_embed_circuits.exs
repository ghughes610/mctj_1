defmodule Mctj.Repo.Migrations.EmbedCircuits do
  use Ecto.Migration

  def change do
    alter table(:workouts) do
      add(:layout, :map,
        default: %{
          circuits: []
        }
      )
    end
  end
end
