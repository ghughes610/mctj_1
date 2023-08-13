defmodule Mctj.Template_ExercisesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mctj.Template_Exercises` context.
  """

  @doc """
  Generate a template_exercise.
  """
  def template_exercise_fixture(attrs \\ %{}) do
    {:ok, template_exercise} =
      attrs
      |> Enum.into(%{
        is_fingers: true,
        metadata: %{},
        movement: "some movement",
        name: "some name",
        plane: "some plane",
        reps: 42,
        time: "some time",
        weight: "some weight"
      })
      |> Mctj.Template_Exercises.create_template_exercise()

    template_exercise
  end
end
