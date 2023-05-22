defmodule Mctj.ExercisesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mctj.Exercises` context.
  """

  @doc """
  Generate a exercise.
  """
  def exercise_fixture(attrs \\ %{}) do
    {:ok, exercise} =
      attrs
      |> Enum.into(%{
        metadata: %{},
        name: "some name",
        reps: "some reps",
        weight: "some weight",
        workout_id: 42
      })
      |> Mctj.Exercises.create_exercise()

    exercise
  end
end
