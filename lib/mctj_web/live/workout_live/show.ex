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

    circuit_1_exercises =
      if workout.layout.circuits do
       Workouts.extract_circuits(workout.layout.circuits)
      else
        [%{}]
      end

    IO.inspect(circuit_1_exercises)

    {:noreply,
     socket
     |> assign(:workout, Workouts.get_workout!(id))
     |> assign(:circuits, workout.layout.circuits)
     |> assign(:circuit_1_exercises, circuit_1_exercises)}
  end
end
