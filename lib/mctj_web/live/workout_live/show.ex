defmodule MctjWeb.WorkoutLive.Show do
  use MctjWeb, :live_view

  alias Mctj.Workouts
  alias Mctj.Exercises

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, add_exercise: false)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    workout = Workouts.get_workout!(id) |> Mctj.Repo.preload(:exercises)

    {:noreply,
     socket
     |> assign(:workout, workout)}
  end

  def handle_event("edit", %{"id" => id}, socket) do
    {:noreply,
     assign(socket, :page_title, "Edit Workout")
     |> assign(:live_action, :edit)}
  end

  def handle_event("add_exercise", params, socket) do
    workout = socket.assigns.workout

    {:noreply, assign(socket, add_exercise: :new)}
  end

  def handle_event(
        "save_exercise",
        %{
          "name" => name,
          "reps" => reps,
          "weight" => weight,
          "circuit_number" => circuit_number
        },
        socket
      ) do
    workout = socket.assigns.workout

    exercise =
      Mctj.Exercises.create_exercise(%{
        "name" => name,
        "reps" => reps,
        "weight" => weight,
        "metadata" => %{
          "circuit_number" => circuit_number,
          "completed_sets" => 0
        },
        "workout_id" => workout.id
      })

    workout = Workouts.get_workout!(workout.id) |> Mctj.Repo.preload([:exercises])

    {:noreply,
     assign(socket,
       add_exercise: false,
       workout: workout
     )}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    exercise = Mctj.Exercises.get_exercise!(String.to_integer(id))
    workout_id = exercise.workout_id

    Mctj.Exercises.delete_exercise(exercise)

    {:noreply,
     assign(socket, workout: Workouts.get_workout!(workout_id) |> Mctj.Repo.preload([:exercises]))}
  end

  def handle_event("complete_set", %{"id" => id}, socket) do
    exercise = Mctj.Exercises.get_exercise!(String.to_integer(id))

    attrs =
      Map.merge(exercise.metadata, %{
        "completed_sets" =>
          check_sets(exercise.metadata["completed_sets"], socket.assigns.workout.sets)
      })

    Exercises.update_exercise(exercise, %{metadata: attrs})

    {:noreply,
     assign(socket,
       workout: Workouts.get_workout!(exercise.workout_id) |> Mctj.Repo.preload([:exercises])
     )}
  end

  defp check_sets(completed_sets, workout_sets), do: if(completed_sets < workout_sets, do: completed_sets + 1, else: workout_sets)


  def completed_bg_color(sets, completed_sets) do
    result = if sets != completed_sets do
        "border-t bg-gray-400"
    else
      "border-t bg-green-200"
    end
  end

end
