defmodule MctjWeb.WorkoutLive.FormComponent do
  use MctjWeb, :live_view

  alias Mctj.Workouts

  @impl true
  def mount(params, session, socket) do
    socket = assign_defaults(session, socket)

    weeks_workouts = Workouts.list_workouts_week(Timex.now(), socket.assigns.current_user.id)

    socket =
      assign(
        socket,
        items: weeks_workouts
      )

    {:ok, assign(socket, :changeset, %{})}
  end

  @impl true
  def handle_params(%{workout: workout} = assigns, socket) do
    changeset = Workouts.change_workout(workout)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  def handle_event(
        "save",
        params,
        socket
      ) do
    params =
      params
      |> Map.put("name", Workouts.generate_workout_name())
      |> Map.put("user_id", socket.assigns.current_user.id)

    socket = assign(socket, :live_action, :new)
    save_workout(socket, socket.assigns.live_action, params)
  end

  @impl true
  def handle_event("save", params, socket) do
    params =
      params
      |> Map.put("metadata", %{})
      |> Map.put("user_id", socket.assigns.current_user.id)

    socket = assign(socket, :live_action, :new)
    save_workout(socket, socket.assigns.live_action, params)
  end

  @impl true
  def handle_event("delete", params, socket) do
    Workouts.delete_workout_by_id(params["id"])

    weeks_workouts = Workouts.list_workouts_week(Timex.now(), socket.assigns.current_user.id)

    socket =
      assign(
        socket,
        items: weeks_workouts
      )

    {:noreply, assign(socket, :changeset, %{})}
  end

  defp save_workout(socket, :edit, workout_params) do
    case Workouts.update_workout(socket.assigns.workout, workout_params) do
      {:ok, _workout} ->
        {:noreply,
        socket
        |> put_flash(:info, "Workout updated successfully")}
        |> push_redirect(to: "/users/workouts")

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_workout(socket, :new, workout_params) do
    workout_params =
      workout_params
      |> Map.put("number_of_circuits", 3)
      |> Map.put("sets", 3)

    case Workouts.create_workout(workout_params) do
      {:ok, workout} ->
        {:noreply,
         socket
         |> put_flash(:info, "Workout created successfully")
         |> push_redirect(to: "/users/workouts/#{workout.id}")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp make_list(input_sting) do
    1..String.to_integer(input_sting) |> Enum.to_list()
  end
end
