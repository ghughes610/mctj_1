defmodule Mctj.Workouts do
  import Ecto.Query, warn: false
  alias Mctj.Repo

  alias Mctj.Workouts.Workout

  def list_workouts do
    Repo.all(Workout)
  end

  def list_user_workouts(id) do
    Workout
    |> where(user_id: ^id)
    |> Repo.all()
  end

  def get_workout!(id), do: Repo.get!(Workout, id)

  def get_exercise_by_uuid(uuid) do
    query = from w in Workout, where: fragment("layout::TEXT LIKE ?", ^"%#{uuid}%")

    layout =
      case Repo.one(query) do
        nil -> nil
        workout -> workout.layout
      end

    for circuit <- layout.circuits,
        {_circuit, exercise_list} <- circuit,
        exercise <- exercise_list,
        exercise["uuid"] == uuid do
      exercise
    end
  end

  def create_workout(attrs \\ %{}) do
    %Workout{}
    |> Workout.changeset(attrs)
    |> Repo.insert()
  end

  def update_workout(%Workout{} = workout, attrs) do
    workout
    |> Workout.changeset(attrs)
    |> Repo.update()
  end

  def delete_workout(%Workout{} = workout) do
    Repo.delete(workout)
  end

  def delete_workout_by_id(id) do
    Repo.delete(get_workout!(id))
  end

  def change_workout(%Workout{} = workout, attrs \\ %{}) do
    Workout.changeset(workout, attrs)
  end

  def list_workouts_week(day),
    do:
      Enum.filter(
        list_workouts(),
        &Timex.between?(&1.inserted_at, Timex.beginning_of_week(day), Timex.end_of_week(day))
      )

  def generate_workout_name(),
    do: "#{Timex.now() |> Timex.weekday() |> Timex.day_shortname()}_default_workout"

  def call_generate_exercise_map(n), do: call_generate_exercise_map(n, [])

  def call_generate_exercise_map(n, acc) when n > 0 do
    exercise_map = generate_exercise_map()
    call_generate_exercise_map(n - 1, [exercise_map | acc])
  end

  # Base case: return the reversed accumulator
  def call_generate_exercise_map(0, acc), do: Enum.reverse(acc)

  def generate_exercise_map() do
    Map.put(%{}, "name", "default_exercise")
    |> Map.put("reps", 8)
    |> Map.put("weight", -1)
    |> Map.put("position", "")
    |> Map.put("sets", 2)
    |> Map.put("completed_sets", 0)
    |> Map.put("uuid", UUID.uuid4())
  end

  def generate_exercise_map(name, position, reps \\ 8, weight \\ -1, sets \\ 3) do
    Map.put(%{}, "name", name)
    |> Map.put("reps", reps)
    |> Map.put("weight", weight)
    |> Map.put("position", position)
    |> Map.put("sets", sets)
    |> Map.put("completed_sets", 0)
    |> Map.put("uuid", UUID.uuid4())
  end

  @moduledoc """
  this should get called first. we will save a template exercise map and update it from there
  this will pattern match on "number_of_exercises_per_circuit" => "1" so we only need one object in list
  """
  def generate_circuit_map() do
    %{
      "circuit_1" => generate_exercise_map()
    }
  end

  def generate_circuit_map(number_of_circuits, exercises_per_circuit) do
    case number_of_circuits do
      "1" ->
        %{
          "circuit_1" =>
            call_generate_exercise_map(String.to_integer(exercises_per_circuit))
        }

      "2" ->
        %{
          "circuit_1" =>
            call_generate_exercise_map(String.to_integer(exercises_per_circuit)),
          "circuit_2" =>
            call_generate_exercise_map(String.to_integer(exercises_per_circuit))
        }

      "3" ->
        %{
          "circuit_1" =>
            call_generate_exercise_map(String.to_integer(exercises_per_circuit)),
          "circuit_2" =>
            call_generate_exercise_map(String.to_integer(exercises_per_circuit)),
          "circuit_3" =>
            call_generate_exercise_map(String.to_integer(exercises_per_circuit))
        }

      "4" ->
        %{
          "circuit_1" =>
            call_generate_exercise_map(String.to_integer(exercises_per_circuit)),
          "circuit_2" =>
            call_generate_exercise_map(String.to_integer(exercises_per_circuit)),
          "circuit_3" =>
            call_generate_exercise_map(String.to_integer(exercises_per_circuit)),
          "circuit_4" =>
            call_generate_exercise_map(String.to_integer(exercises_per_circuit))
        }

      "5" ->
        %{
          "circuit_1" =>
            call_generate_exercise_map(String.to_integer(exercises_per_circuit)),
          "circuit_2" =>
            call_generate_exercise_map(String.to_integer(exercises_per_circuit)),
          "circuit_3" =>
            call_generate_exercise_map(String.to_integer(exercises_per_circuit)),
          "circuit_4" =>
            call_generate_exercise_map(String.to_integer(exercises_per_circuit)),
          "circuit_5" =>
            call_generate_exercise_map(String.to_integer(exercises_per_circuit))
        }
    end
  end

  def extract_circuits(circuits \\ [], circuit_name) do
    circuit_1_exercises =
      Enum.map(circuits, fn circuit ->
        case Map.has_key?(circuit, circuit_name) do
          true ->
            Enum.map(circuit[circuit_name], fn exercise ->
              exercise
            end)

          false ->
            []
        end
      end)

    List.flatten(circuit_1_exercises)
  end
end
