defmodule Mctj.Template_Exercises do
  import Ecto.Query, warn: false
  alias Mctj.Repo

  alias Mctj.Template_Exercises.Template_exercise

  def list_template_exercises do
    Repo.all(Template_exercise)
  end

  def get_warm_up() do
    kb_press =
      Template_exercise
      |> where(name: "kettlebell swing press")
      |> Repo.one()

    anti_rows =
      Template_exercise
      |> where(name: "Anti Rows")
      |> Repo.one()

    iso_pulls =
      Template_exercise
      |> where(name: "Single Arm Pull")
      |> Repo.one()

      [iso_pulls, anti_rows, kb_press]
  end

  def get_random_cross_training_exercise() do
    list_template_exercises()
    |> Enum.filter(&(&1.is_fingers == false))
    |> Enum.random()
  end

  def get_random_iso_finger_exercise() do
    list_template_exercises()
    |> Enum.filter(&(&1.is_fingers == true))
    |> Enum.filter(&(&1.weight == "iso"))
    |> Enum.random()
  end

  def get_random_endurance_exercise() do
    list_template_exercises()
    |> Enum.filter(&(&1.time == "30"))
    |> Enum.random()
  end

  def get_random_weighted_finger_exercise() do
    list_template_exercises()
    |> Enum.filter(&(&1.is_fingers == true))
    |> Enum.filter(&(&1.weight != "iso"))
    |> Enum.random()
  end

  def get_template_exercise!(id), do: Repo.get!(Template_exercise, id)

  def create_template_exercise(attrs \\ %{}) do
    %Template_exercise{}
    |> Template_exercise.changeset(attrs)
    |> Repo.insert()
  end

  def update_template_exercise(%Template_exercise{} = template_exercise, attrs) do
    template_exercise
    |> Template_exercise.changeset(attrs)
    |> Repo.update()
  end

  def delete_template_exercise(%Template_exercise{} = template_exercise) do
    Repo.delete(template_exercise)
  end

  def change_template_exercise(%Template_exercise{} = template_exercise, attrs \\ %{}) do
    Template_exercise.changeset(template_exercise, attrs)
  end
end

# Mctj.Template_Exercises.generate_warm_up()
