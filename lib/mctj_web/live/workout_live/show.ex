defmodule MctjWeb.WorkoutLive.Show do
  use MctjWeb, :live_view

  alias Mctj.Workouts

  @impl true
  def mount(_params, _session, socket) do
    IO.inspect(socket.assigns, label: :socket)
    {:ok, socket}

  end

  @impl true
  def handle_params(%{"id" => id}, stuff, socket) do
    workout = Workouts.get_workout!(id)
    IO.inspect(workout)

    circuits =
      if workout.layout.circuits do
        workout.layout.circuits
      else
        [%{}]
      end

      IO.inspect(circuits, label: :circuits)



    {:noreply,
     socket
     |> assign(:workout, Workouts.get_workout!(id))
     |> assign(:circuits, circuits)}
  end
end
