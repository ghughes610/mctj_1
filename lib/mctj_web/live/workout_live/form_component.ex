defmodule MctjWeb.WorkoutLive.FormComponent do
  use MctjWeb, :live_view

  alias Mctj.Workouts

  @impl true
  def mount(params, session, socket) do
    socket = assign_defaults(session, socket)

    weeks_workouts = Workouts.list_workouts_week(Timex.now())
    socket = assign(
      socket,
      items: weeks_workouts
      # module: TrainingJournalWeb.CircuitLive
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



  @impl true
  def handle_event("save", params , socket) do

    IO.inspect(params, label: :params)
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

    weeks_workouts = Workouts.list_workouts_week(Timex.now())
    socket = assign(
      socket,
      items: weeks_workouts
      # module: TrainingJournalWeb.CircuitLive
    )
    {:noreply, assign(socket, :changeset, %{})}
  end

  @impl true
  def handle_event("add_exercise", params, socket) do
    IO.inspect(params, label: :params)
    {:noreply, socket}
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
    case Workouts.create_workout(workout_params) do
      {:ok, _workout} ->
        {:noreply,
         socket
         |> put_flash(:info, "Workout created successfully")
         |> push_redirect(to: "/users/workouts")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end


  #  c =
  #     %{
  #       layout: %{
  #         sets: 1,
  #         rest_time: 60,
  #         circuits: [
  #           %{
  #             "1" => %{
  #               "exercise_1" => %{
  #                 "name" => "",
  #                 "reps" => 10,
  #                 "weight" => 0
  #               },
  #               "exercise_2" => %{
  #                 "name" => "",
  #                 "reps" => 10,
  #                 "weight" => 0
  #               },
  #               "exercise_3" => %{
  #                 "name" => "",
  #                 "reps" => 10,
  #                 "weight" => 0
  #               }
  #             }
  #           }
  #         ]
  #       }
  #     }
