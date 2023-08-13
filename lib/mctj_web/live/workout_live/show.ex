defmodule MctjWeb.WorkoutLive.Show do
  use MctjWeb, :live_view

  alias Mctj.Workouts
  alias Mctj.Exercises
  alias Mctj.Template_Exercises

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, add_exercise: false)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(
       :workout,
       Workouts.sort_workouts_exercises(
         Workouts.get_workout!(id)
         |> Mctj.Repo.preload(:exercises)
       )
     )}
  end

  @impl true
  def handle_event("edit", %{"id" => id}, socket) do
    {:noreply,
     assign(socket, :page_title, "Edit Exercise")
     |> assign(:live_action, :edit_exercise)
     |> assign(:exercise, Mctj.Exercises.get_exercise!(String.to_integer(id)))}
  end

  @impl true
  def handle_event("add_exercise", params, socket) do
    {:noreply, assign(socket, add_exercise: :new)}
  end

  def handle_event("generate_exercise", _params, socket) do
    IO.inspect(socket.assigns.workout, label: :workout)

    workout = socket.assigns.workout

    exercise = generate_workout_by_type(workout.type)

    final_exercise =
      if Enum.empty?(workout.exercises) do
        exercise
      else
        if Enum.filter(workout.exercises, &(&1.name == exercise.name)) do
          generate_workout_by_type(workout.type)
        else
          exercise
        end
      end
      |> Map.take([:is_fingers, :metadata, :movement, :name, :plane, :reps, :time, :weight])

    IO.inspect(final_exercise, labal: :final_exercise)



    {:noreply,
     assign(socket,
       add_exercise: false,
       workout:
         Workouts.sort_workouts_exercises(
           Workouts.get_workout!(workout.id)
           |> Mctj.Repo.preload(:exercises)
         )
     )}
  end

  def handle_event("generate_warm_up", _params, socket) do
    {:noreply, socket}
  end

  def handle_event(
        "save_exercise",
        _params,
        socket
      ) do
    workout = socket.assigns.workout

    {:noreply,
     assign(socket,
       add_exercise: false,
       workout:
         Workouts.sort_workouts_exercises(
           Workouts.get_workout!(workout.id)
           |> Mctj.Repo.preload(:exercises)
         )
     )}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    exercise = Mctj.Exercises.get_exercise!(String.to_integer(id))
    workout_id = exercise.workout_id

    Mctj.Exercises.delete_exercise(exercise)

    {:noreply,
     assign(socket,
       workout:
         Workouts.sort_workouts_exercises(
           Workouts.get_workout!(workout_id)
           |> Mctj.Repo.preload(:exercises)
         )
     )}
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
       workout: assign_workout_to_socket(exercise)
     )}
  end

  defp check_sets(completed_sets, workout_sets),
    do: if(completed_sets < workout_sets, do: completed_sets + 1, else: workout_sets)

  def completed_bg_color(sets, completed_sets) do
    if sets != completed_sets do
      "border-t bg-gray-900"
    else
      "border-t bg-green-200"
    end
  end

  defp assign_workout_to_socket(exercise) do
    Workouts.get_workout!(exercise.workout_id)
    |> Mctj.Repo.preload([:exercises])
    |> Workouts.sort_workouts_exercises()
  end

  defp generate_workout_by_type(type) do
    case String.downcase(type) do
      "endurance" -> Template_Exercises.get_random_endurance_exercise()
      "power endurance" -> Template_Exercises.get_random_cross_training_exercise()
      "power" -> Template_Exercises.get_random_cross_training_exercise()
    end
  end
end
