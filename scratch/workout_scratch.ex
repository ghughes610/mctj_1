alias Mctj.Workouts.Workout
alias Mctj.Repo

default_shape =
  %{
    name: "test_workout",
    type: "power",
    layout: %{
      sets: 1,
      rest_time: 60,
      circuits: [
          %{
            "circuit_1" => [
            %{
              "name" => "incline bench press",
              "reps" => 8,
              "weight" => 135,
              "order" => 1
            },
            %{
              "name" => "deadlift",
              "reps" => 8,
              "weight" => 210,
              "order" => 2
            },
            %{
              "name" => "max hangs",
              "reps" => 5,
              "weight" => 45,
              "order" => 3
            }
          ]
        }
      ]
    }
  }

changeset = Workout.changeset(%Workout{}, default_shape)
Repo.insert!(changeset)
