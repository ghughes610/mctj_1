defmodule MctjWeb.WorkoutLive.Index do
  use MctjWeb, :live_view

  alias Mctj.Accounts
  alias Mctj.Workouts
  alias Mctj.Workouts.Workout

  @impl true
  def mount(params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])
    socket = assign_defaults(session, socket)

    {:ok, assign(socket, :workouts, Workouts.list_user_workouts(user.id))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Workout")
    |> assign(:workout, Workouts.get_workout!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Workout")
    |> assign(:workout, %Workout{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Workouts")
    |> assign(:workout, nil)
  end

  defp apply_action(socket, nil, _params) do
    socket
    |> assign(:page_title, "New Workout")
    |> assign(:workout, %Workout{})
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    workout = Workouts.get_workout!(id)
    {:ok, _} = Workouts.delete_workout(workout)

    {:noreply,
     assign(socket, :workouts, Workouts.list_user_workouts(socket.assigns.current_user.id))}
  end

  defp list_workouts do
    Workouts.list_workouts()
  end
end
