defmodule Mctj.DataCenter.ExerciseDataCenter do
  # 1 stands for "Forward" movement.
  # 2 stands for "Side" movement.
  # 3 stands for "Twisting" movement.

  def get_warm_up_exercises() do
    [
      %{name: "swinging kettlebell press", weight: 15, reps: 10, movement: "Forward", group: 1},
      %{name: "trx pushups", weight: nil, reps: 15, movement: "Forward", group: 1},
      %{name: "anti rows", weight: 20, reps: 12, movement: "Forward", group: 3},
      %{name: "1 arm iso hangs over head", weight: nil, reps: 8, movement: "Side", group: 2},
      %{name: "1 arm iso hangs row", weight: 25, reps: 10, movement: "Side", group: 2},
      %{name: "tri exts", weight: 10, reps: 12, movement: "Side", group: 2},
      %{name: "trx bridges", weight: nil, reps: 10, movement: "Twisting", group: 3},
      %{name: "trx iyt", weight: nil, reps: 12, movement: "Twisting", group: 3},
      %{name: "jump rope", weight: nil, reps: 100, movement: "Twisting", group: 3},
      %{name: "trx single leg squats", weight: nil, reps: 8, movement: "Side", group: 2},
      %{name: "kettlebell side swings", weight: 20, reps: 15, movement: "Forward", group: 1}
    ]
  end
end
