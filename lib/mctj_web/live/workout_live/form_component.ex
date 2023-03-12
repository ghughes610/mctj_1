defmodule MctjWeb.WorkoutLive.FormComponent do
  use MctjWeb, :live_view

  alias Mctj.Workouts
  
  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)

    {:ok, assign(socket, :changeset, %{})}
  end

  @impl true
  def update(%{workout: workout} = assigns, socket) do
    changeset = Workouts.change_workout(workout)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  # @impl true
  # def handle_event("validate", %{"workout" => workout_params}, socket) do
  #   changeset =
  #     socket.assigns.workout
  #     |> Workouts.change_workout(workout_params)
  #     |> Map.put(:action, :validate)

  #   {:noreply, assign(socket, :changeset, changeset)}
  # end
  @impl true
  def handle_event("save", params , socket) do
    params =
      params
      |> Map.put("metadata", %{})
      |> Map.put("user_id", socket.assigns.current_user.id)

    socket = assign(socket, :live_action, :new)
    save_workout(socket, socket.assigns.live_action, params)
  end

  defp save_workout(socket, :edit, workout_params) do
    case Workouts.update_workout(socket.assigns.workout, workout_params) do
      {:ok, _workout} ->
        {:noreply,
         socket
         |> put_flash(:info, "Workout updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_workout(socket, :new, workout_params) do
    case Workouts.create_workout(workout_params) do
      {:ok, _workout} ->
        {:noreply,
         socket
         |> put_flash(:info, "Workout created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
