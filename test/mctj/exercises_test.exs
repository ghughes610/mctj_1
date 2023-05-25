defmodule Mctj.ExercisesTest do
  use Mctj.DataCase

  alias Mctj.Exercises

  describe "exercises" do
    alias Mctj.Exercises.Exercise

    import Mctj.ExercisesFixtures

    @invalid_attrs %{metadata: nil, name: nil, reps: nil, weight: nil, workout_id: nil}

    test "list_exercises/0 returns all exercises" do
      exercise = exercise_fixture()
      assert Exercises.list_exercises() == [exercise]
    end

    test "get_exercise!/1 returns the exercise with given id" do
      exercise = exercise_fixture()
      assert Exercises.get_exercise!(exercise.id) == exercise
    end

    test "create_exercise/1 with valid data creates a exercise" do
      valid_attrs = %{
        metadata: %{},
        name: "some name",
        reps: "some reps",
        weight: "some weight",
        workout_id: 42
      }

      assert {:ok, %Exercise{} = exercise} = Exercises.create_exercise(valid_attrs)
      assert exercise.metadata == %{}
      assert exercise.name == "some name"
      assert exercise.reps == "some reps"
      assert exercise.weight == "some weight"
      assert exercise.workout_id == 42
    end

    test "create_exercise/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Exercises.create_exercise(@invalid_attrs)
    end

    test "update_exercise/2 with valid data updates the exercise" do
      exercise = exercise_fixture()

      update_attrs = %{
        metadata: %{},
        name: "some updated name",
        reps: "some updated reps",
        weight: "some updated weight",
        workout_id: 43
      }

      assert {:ok, %Exercise{} = exercise} = Exercises.update_exercise(exercise, update_attrs)
      assert exercise.metadata == %{}
      assert exercise.name == "some updated name"
      assert exercise.reps == "some updated reps"
      assert exercise.weight == "some updated weight"
      assert exercise.workout_id == 43
    end

    test "update_exercise/2 with invalid data returns error changeset" do
      exercise = exercise_fixture()
      assert {:error, %Ecto.Changeset{}} = Exercises.update_exercise(exercise, @invalid_attrs)
      assert exercise == Exercises.get_exercise!(exercise.id)
    end

    test "delete_exercise/1 deletes the exercise" do
      exercise = exercise_fixture()
      assert {:ok, %Exercise{}} = Exercises.delete_exercise(exercise)
      assert_raise Ecto.NoResultsError, fn -> Exercises.get_exercise!(exercise.id) end
    end

    test "change_exercise/1 returns a exercise changeset" do
      exercise = exercise_fixture()
      assert %Ecto.Changeset{} = Exercises.change_exercise(exercise)
    end
  end
end
