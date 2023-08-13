defmodule Mctj.Template_ExercisesTest do
  use Mctj.DataCase

  alias Mctj.Template_Exercises

  describe "template_exercises" do
    alias Mctj.Template_Exercises.Template_exercise

    import Mctj.Template_ExercisesFixtures

    @invalid_attrs %{is_fingers: nil, metadata: nil, movement: nil, name: nil, plane: nil, reps: nil, time: nil, weight: nil}

    test "list_template_exercises/0 returns all template_exercises" do
      template_exercise = template_exercise_fixture()
      assert Template_Exercises.list_template_exercises() == [template_exercise]
    end

    test "get_template_exercise!/1 returns the template_exercise with given id" do
      template_exercise = template_exercise_fixture()
      assert Template_Exercises.get_template_exercise!(template_exercise.id) == template_exercise
    end

    test "create_template_exercise/1 with valid data creates a template_exercise" do
      valid_attrs = %{is_fingers: true, metadata: %{}, movement: "some movement", name: "some name", plane: "some plane", reps: 42, time: "some time", weight: "some weight"}

      assert {:ok, %Template_exercise{} = template_exercise} = Template_Exercises.create_template_exercise(valid_attrs)
      assert template_exercise.is_fingers == true
      assert template_exercise.metadata == %{}
      assert template_exercise.movement == "some movement"
      assert template_exercise.name == "some name"
      assert template_exercise.plane == "some plane"
      assert template_exercise.reps == 42
      assert template_exercise.time == "some time"
      assert template_exercise.weight == "some weight"
    end

    test "create_template_exercise/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Template_Exercises.create_template_exercise(@invalid_attrs)
    end

    test "update_template_exercise/2 with valid data updates the template_exercise" do
      template_exercise = template_exercise_fixture()
      update_attrs = %{is_fingers: false, metadata: %{}, movement: "some updated movement", name: "some updated name", plane: "some updated plane", reps: 43, time: "some updated time", weight: "some updated weight"}

      assert {:ok, %Template_exercise{} = template_exercise} = Template_Exercises.update_template_exercise(template_exercise, update_attrs)
      assert template_exercise.is_fingers == false
      assert template_exercise.metadata == %{}
      assert template_exercise.movement == "some updated movement"
      assert template_exercise.name == "some updated name"
      assert template_exercise.plane == "some updated plane"
      assert template_exercise.reps == 43
      assert template_exercise.time == "some updated time"
      assert template_exercise.weight == "some updated weight"
    end

    test "update_template_exercise/2 with invalid data returns error changeset" do
      template_exercise = template_exercise_fixture()
      assert {:error, %Ecto.Changeset{}} = Template_Exercises.update_template_exercise(template_exercise, @invalid_attrs)
      assert template_exercise == Template_Exercises.get_template_exercise!(template_exercise.id)
    end

    test "delete_template_exercise/1 deletes the template_exercise" do
      template_exercise = template_exercise_fixture()
      assert {:ok, %Template_exercise{}} = Template_Exercises.delete_template_exercise(template_exercise)
      assert_raise Ecto.NoResultsError, fn -> Template_Exercises.get_template_exercise!(template_exercise.id) end
    end

    test "change_template_exercise/1 returns a template_exercise changeset" do
      template_exercise = template_exercise_fixture()
      assert %Ecto.Changeset{} = Template_Exercises.change_template_exercise(template_exercise)
    end
  end
end
