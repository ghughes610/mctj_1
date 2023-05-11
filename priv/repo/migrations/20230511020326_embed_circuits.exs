defmodule Mctj.Repo.Migrations.EmbedCircuits do
  use Ecto.Migration

  def change do
    alter table(:workouts) do
      add :circuits, :map, default: %{
        "1" => %{
          "name" => "",
          "reps" => 10,
          "weight" => 0
        },
        "2" => %{
          "name" => "",
          "reps" => 10,
          "weight" => 0
        },
        "3" => %{
          "name" => "",
          "reps" => 10,
          "weight" => 0
        }
      }
    end
  end
end
