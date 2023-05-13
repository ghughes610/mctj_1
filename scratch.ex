alias Mctj.Workouts.Workout

c =
  %{
    layout: %{
      sets: 1,
      rest_time: 60,
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
  }

Workout.changeset(%Workout{}, c)
