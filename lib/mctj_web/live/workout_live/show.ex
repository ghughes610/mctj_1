defmodule MctjWeb.WorkoutLive.Show do
  use MctjWeb, :live_view

  alias Mctj.Workouts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}

  end

  @impl true
  def handle_params(%{"id" => id}, stuff, socket) do
    workout = Workouts.get_workout!(id)

    circuit_1_exercises = Workouts.extract_circuits(workout.layout.circuits, "circuit_1")

    circuit_2_exercises = Workouts.extract_circuits(workout.layout.circuits, "circuit_2")

    circuit_3_exercises = Workouts.extract_circuits(workout.layout.circuits, "circuit_3")

    {:noreply,
     socket
     |> assign(:workout, Workouts.get_workout!(id))
     |> assign(:circuits, [circuit_1_exercises, circuit_2_exercises, circuit_1_exercises])
     |> assign(:circuit_1_exercises, circuit_1_exercises)
     |> assign(:circuit_2_exercises, circuit_2_exercises)
     |> assign(:circuit_3_exercises, circuit_3_exercises)}
  end
end
