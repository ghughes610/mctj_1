defmodule Mctj.Workouts do
  import Ecto.Query, warn: false
  alias Mctj.Repo

  alias Mctj.Workouts.Workout

  def list_workouts do
    Repo.all(Workout)
  end

  def get_workout!(id), do: Repo.get!(Workout, id)

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

  def generate_exercise_map(name, position, reps \\ 8, weight \\ -1, sets \\ 3) do
    Map.put(%{}, "name", name)
    |> Map.put("reps", reps)
    |> Map.put("weight", weight)
    |> Map.put("position", position)
    |> Map.put("sets", sets)
  end

  @moduledoc """
  this should get called first. we will save a template exercise map and update it from there
  this will pattern match on "number_of_exercises_per_circuit" => "1" so we only need one object in list
  """
  def generate_circuit_map() do
    %{
      "circuit_1" => [
        Map.put(%{}, "name", "default_exercise")
        |> Map.put("reps", 8)
        |> Map.put("weight", -1)
        |> Map.put("position", "")
        |> Map.put("sets", 2)
      ]
    }
  end

  def extract_circuits(circuits \\ [], circuit_name) do
    circuit_1_exercises =
      Enum.map(circuits, fn circuit ->
        case Map.has_key?(circuit, circuit_name) do
          true ->
            Enum.map(circuit[circuit_name], fn exercise ->
              exercise
            end)
          false -> []
        end
      end)

    List.flatten(circuit_1_exercises)
  end
end
