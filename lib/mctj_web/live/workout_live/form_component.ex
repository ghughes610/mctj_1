defmodule MctjWeb.WorkoutLive.FormComponent do
  use MctjWeb, :live_view

  alias Mctj.Workouts

  @impl true
  def mount(params, session, socket) do
    socket = assign_defaults(session, socket)

    weeks_workouts = Workouts.list_workouts_week(Timex.now())

    socket =
      assign(
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
  @moduledoc """
  If the user just clicks the save button without any entries to the form we will make the assumption that they are in a rush and these values might be defaults of sorts.
  """
  def handle_event(
        "save",
        %{
          "circuit_sets" => "2",
          "days_on" => "0",
          "freshness" => "50",
          "number_of_circuits" => "1",
          "type" => "Power Endurance",
          "number_of_exercises_per_circuit" => "1"
        } = params,
        socket
      ) do
    params =
      params
      |> Map.put("name", Workouts.generate_workout_name())
      |> Map.put("metadata", %{"user_engagement" => "0"})
      |> Map.put("user_id", socket.assigns.current_user.id)
      |> Map.put("layout", %{circuits: [Workouts.generate_circuit_map()]})

    socket = assign(socket, :live_action, :new)
    save_workout(socket, socket.assigns.live_action, params)
  end

  def handle_event(
        "save",
        %{
          "number_of_circuits" => number_of_circuits,
          "number_of_exercises_per_circuit" => number_of_exercises_per_circuit
        } = params,
        socket
      ) do
    IO.inspect(number_of_circuits, label: :number_of_circuits)
    IO.inspect(number_of_exercises_per_circuit, label: :number_of_exercises_per_circuit)

    params =
      params
      |> Map.put("name", Workouts.generate_workout_name())
      |> Map.put("metadata", %{"user_engagement" => "1"})
      |> Map.put("user_id", socket.assigns.current_user.id)
      |> Map.put("layout", %{
        circuits: [
          Workouts.generate_circuit_map(number_of_circuits, number_of_exercises_per_circuit)
        ]
      })

    socket = assign(socket, :live_action, :new)
    save_workout(socket, socket.assigns.live_action, params)
  end

  @impl true
  def handle_event("save", params, socket) do
    params =
      params
      |> Map.put("metadata", %{})
      |> Map.put("user_id", socket.assigns.current_user.id)

    # |> Map.put("layout", %{circuits: []})

    socket = assign(socket, :live_action, :new)
    save_workout(socket, socket.assigns.live_action, params)
  end

  @impl true
  def handle_event("delete", params, socket) do
    Workouts.delete_workout_by_id(params["id"])

    weeks_workouts = Workouts.list_workouts_week(Timex.now())

    socket =
      assign(
        socket,
        items: weeks_workouts
        # module: TrainingJournalWeb.CircuitLive
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
