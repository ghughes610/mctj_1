defmodule Mctj.Repo.Migrations.EmbedCircuits do
  use Ecto.Migration

  def change do
    alter table(:workouts) do
      add(:layout, :map,
        default: %{
          circuits: [
            %{
              "1" => %{
                "exercise_1" => %{
                  "name" => "",
                  "reps" => 10,
                  "weight" => 0
                },
                "exercise_2" => %{
                  "name" => "",
                  "reps" => 10,
                  "weight" => 0
                },
                "exercise_3" => %{
                  "name" => "",
                  "reps" => 10,
                  "weight" => 0
                }
              }
            }
          ]
        }
      )
    end
  end
end
