defmodule MctjWeb.WorkoutLive.Show do
  use MctjWeb, :live_view

  alias Mctj.Workouts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    workout = Workouts.get_workout!(id)
    circuit_1_exercises = Workouts.extract_circuits(workout.layout.circuits, "circuit_1")
    circuit_2_exercises = Workouts.extract_circuits(workout.layout.circuits, "circuit_2")
    circuit_3_exercises = Workouts.extract_circuits(workout.layout.circuits, "circuit_3")
    circuit_4_exercises = Workouts.extract_circuits(workout.layout.circuits, "circuit_4")
    circuit_5_exercises = Workouts.extract_circuits(workout.layout.circuits, "circuit_5")

    {:noreply,
     socket
     |> assign(:workout, Workouts.get_workout!(id))
     |> assign(:circuits, [circuit_1_exercises, circuit_2_exercises, circuit_1_exercises])
     |> assign(:circuit_1_exercises, circuit_1_exercises)
     |> assign(:circuit_2_exercises, circuit_2_exercises)
     |> assign(:circuit_3_exercises, circuit_3_exercises)
     |> assign(:circuit_4_exercises, circuit_4_exercises)
     |> assign(:circuit_5_exercises, circuit_5_exercises)}
  end

  # def handle_event("complete_set", unsigned_params, socket) do
  #   IO.inspect(unsigned_params, label: :unsigned_params)
  #   {:noreply, socket}
  # end

  def handle_event("edit", %{"id" => id}, socket) do
    {:noreply,
     assign(socket, :page_title, "Edit Workout")
     |> assign(:live_action, :edit)
     |> assign(:exercise_id, id)}
  end

  def handle_event("save_exercise", params, socket) do
    workout = socket.assigns.workout

    [exercise] = Workouts.get_exercise_by_uuid(socket.assigns.exercise_id)

    # we need to update the workouts layout with the exercise above to do that we might need to rename the exercise name key 

    IO.inspect(exercise, label: :exercise_1)

    workout = Workouts.update_workout(socket.assigns.workout, exercise)


    {:noreply, socket}
  end
end

# params: %{
#   "exercise_id" => "7f318c8d-4908-486a-aeb6-5e7e479e1471",
#   "name" => "Incline bench press",
#   "reps" => "8",
#   "weight" => "165"
# }
