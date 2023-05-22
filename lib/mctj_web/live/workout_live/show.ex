defmodule MctjWeb.WorkoutLive.Show do
  use MctjWeb, :live_view

  alias Mctj.Workouts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, add_exercise: false)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:workout, Workouts.get_workout!(id))}
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

  def handle_event("save_exercise", params, socket) do
    workout = socket.assigns.workout

    {:noreply, assign(socket, add_exercise: false)}
  end
end
