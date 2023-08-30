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
    workout = socket.assigns.workout

    check_dupe_and_generate_exercise(workout)
    |> merge_template(workout)
    |> Exercises.create_exercise()

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
        params,
        socket
      ) do
    workout = socket.assigns.workout

    attrs = Map.put(params, "workout_id", workout.id)
    Exercises.create_exercise(attrs)

    # <button type="button" phx-click="add_exercise"
    #   class="relative -ml-px inline-flex items-center rounded-r-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-10 mx-1">Create Custom Exercise</button>

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
            else
              IO.inspect("We have a problem 1")
            end
          end)

        exercises =
          if Enum.count(exercises) == 1 do
            exercises
          else
            IO.inspect("We have a problem 2")
          end

        Enum.at(exercises, 0)
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
    IO.inspect(attrs)
    IO.inspect(workout)

    circuit_number =
      if workout.exercises == %{} do
        "1"
      else
        IO.inspect(workout.exercises)

        cond do
          workout.exercises["1"] == nil ->
            "1"
          workout.exercises["1"] ->
            if Enum.count(workout.exercises["1"]) == 3 do
              "2"
            else
              "1"
            end

          workout.exercises["2"] == nil -> "2"
          workout.exercises["2"] ->
            if Enum.count(workout.exercises["2"]) == 3 do
              "3"
            else
              "2"
            end
          workout.exercises["3"] == nil -> "3"
          workout.exercises["3"] ->
            if Enum.count(workout.exercises["3"]) == 3 do
              "3"
            else
              "This is an extra circuit!"
            end
        end

          # "1" => [
          #     %Mctj.Exercises.Exercise{
          #       __meta__: #Ecto.Schema.Metadata<:loaded, "exercises">,
          #       id: 110,
          #       metadata: %{
          #         "circuit_number" => "1",
          #         "completed_sets" => 0,
          #         "is_fingers" => nil,
          #         "movement" => nil,
          #         "plane" => nil,
          #         "sets" => 3,
          #         "time" => nil
          #       },
          #       name: "Trx Tricep Extensions",
          #       reps: "0",
          #       weight: "vest",
          #       inserted_at: ~N[2023-08-30 02:53:49],
          #       updated_at: ~N[2023-08-30 02:53:49],
          #       workout_id: 14,
          #       workout: #Ecto.Association.NotLoaded<association :workout is not loaded>
          #     }
          #   ]

        # "this is a placeholder"
        # "#{Map.size(workout.exercises) + 1} exercises in this circuit"
        # cond do
        #   exercise.metadata["circuit_number"] == "1" -> "1"
        #   exercise.metadata["circuit_number"] == "2" -> "2"
        #   exercise.metadata["circuit_number"] == "3" -> "3"
        # end
      end

    %{
      workout_id: workout.id,
      metadata: %{
        "sets" => workout.sets,
        "completed_sets" => 0,
        "is_fingers" => attrs["is_fingers"],
        "movement" => attrs["movement"],
        "plane" => attrs["plane"],
        "time" => attrs["time"],
        "circuit_number" => circuit_number
      },
      name: attrs.name,
      reps:
        if attrs.reps - 1 do
          Integer.to_string(attrs.reps)
        else
          attrs.reps
        end,
      weight: attrs.weight
    }
  end

  defp deconstruct_exercises(exercises) do
    Enum.map(exercises, fn {_, exercises} ->
      Enum.map(exercises, fn exercise ->
        exercise
      end)
    end)
  end
end
