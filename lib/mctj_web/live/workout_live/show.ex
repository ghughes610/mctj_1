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
  def handle_event("add_exercise", _params, socket) do
    {:noreply, assign(socket, add_exercise: :new)}
  end

  def handle_event("generate_exercise", _params, socket) do
    check_dupe_and_generate_exercise(socket.assigns.workout)
    |> merge_template(socket.assigns.workout)
    |> Exercises.create_exercise()

    build_and_assign_socket(socket)
  end

  def handle_event("generate_warm_up", _params, socket) do
    Enum.map(Template_Exercises.get_warm_up(), fn e ->
      Map.from_struct(e)
      |> Map.new(fn {k, v} -> {Atom.to_string(k), v} end)
      |> merge_template(socket.assigns.workout)
      |> Exercises.create_exercise()
    end)

    build_and_assign_socket(socket)
  end

  def handle_event(
        "save_exercise",
        params,
        socket
      ) do
    workout = socket.assigns.workout
    Exercises.create_exercise(Map.put(params, "workout_id", workout.id))

    # <button type="button" phx-click="add_exercise"
    #   class="relative -ml-px inline-flex items-center rounded-r-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-10 mx-1">Create Custom Exercise</button>

    build_and_assign_socket(socket)
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

  defp generate_workout_by_type(type, exercise \\ nil) do
    if !exercise do
      parse_and_get_exercise(type)
    else
      # this should not be the exercise that was just generated
      parse_and_get_exercise(type, exercise)
    end
  end

  defp check_dupe_and_generate_exercise(workout) do
    generated_exercise = generate_workout_by_type(workout.type)

    generated_exercise =
      if Enum.empty?(workout.exercises) do
        generated_exercise
      else
        exercises =
          Enum.map(deconstruct_exercises(workout.exercises), fn exercises_array ->
            duped_exercises =
              Enum.filter(exercises_array, fn exercise ->
                exercise.name == generated_exercise.name
              end)

            if Enum.count(duped_exercises) == 0 do
              generated_exercise
            end
          end)

        if Enum.count(exercises) == 1 do
          Enum.at(exercises, 0)
        else
          # use the generate_workout_by_type/2 function to generate a new exercise and exclude the exercise that was passed in
          generate_workout_by_type(workout.type)
        end
      end

    Map.take(generated_exercise, [
      :is_fingers,
      :metadata,
      :movement,
      :name,
      :plane,
      :reps,
      :time,
      :weight
    ])
  end

  defp merge_template(attrs, workout) do
    %{
      workout_id: workout.id,
      metadata: %{
        "sets" => workout.sets,
        "completed_sets" => 0,
        "is_fingers" => attrs["is_fingers"],
        "edge_size" => attrs["edge_size"],
        "movement" => attrs["movement"],
        "plane" => attrs["plane"],
        "time" => attrs["time"],
        "circuit_number" => put_circuit_number(workout)
      },
      name: attrs["name"] || attrs.name,
      reps:
        if attrs["reps"] || attrs.reps - 1 do
          Integer.to_string(attrs["reps"] || attrs.reps)
        else
          attrs["reps"] || attrs.reps
        end,
      weight: attrs["weight"] || attrs.weight
    }
  end

  defp deconstruct_exercises(exercises) do
    Enum.map(exercises, fn {_, exercises} ->
      Enum.map(exercises, fn exercise ->
        exercise
      end)
    end)
  end

  defp parse_and_get_exercise(type) do
    case String.downcase(type) do
      "endurance" -> Template_Exercises.get_random_endurance_exercise()
      "power endurance" -> Template_Exercises.get_random_cross_training_exercise()
      "power" -> Template_Exercises.get_random_cross_training_exercise()
    end
  end

  defp parse_and_get_exercise(type, exercise) do
    new_exercise =
      case String.downcase(type) do
        "endurance" -> Template_Exercises.get_random_endurance_exercise(exercise)
        "power endurance" -> Template_Exercises.get_random_cross_training_exercise(exercise)
        "power" -> Template_Exercises.get_random_cross_training_exercise(exercise)
      end

    if new_exercise.name == exercise.name do
      case String.downcase(type) do
        "endurance" -> Template_Exercises.get_random_endurance_exercise(exercise)
        "power endurance" -> Template_Exercises.get_random_cross_training_exercise(exercise)
        "power" -> Template_Exercises.get_random_cross_training_exercise(exercise)
      end
    end
  end

  defp put_circuit_number(workout) do
    if workout.exercises == %{} do
      "1"
    else
      Enum.find_value(1..3, fn circuit_number ->
        exercises = workout.exercises[Integer.to_string(circuit_number)]

        if exercises == nil or Enum.count(exercises) < 3 do
          Integer.to_string(circuit_number)
        end
      end) || "3"
    end
  end

  defp assign_workout_to_socket(exercise) do
    Workouts.get_workout!(exercise.workout_id)
    |> Mctj.Repo.preload([:exercises])
    |> Workouts.sort_workouts_exercises()
  end

  defp build_and_assign_socket(socket) do
     {:noreply,
     assign(socket,
       add_exercise: false,
       workout:
         Workouts.sort_workouts_exercises(
           Workouts.get_workout!(socket.assigns.workout.id)
           |> Mctj.Repo.preload(:exercises)
         )
     )}
  end
end
