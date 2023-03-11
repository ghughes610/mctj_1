defmodule MctjWeb.WorkoutLiveTest do
  use MctjWeb.ConnCase

  import Phoenix.LiveViewTest
  import Mctj.WorkoutsFixtures

  @create_attrs %{name: "some name", type: "some type"}
  @update_attrs %{name: "some updated name", type: "some updated type"}
  @invalid_attrs %{name: nil, type: nil}

  defp create_workout(_) do
    workout = workout_fixture()
    %{workout: workout}
  end

  describe "Index" do
    setup [:create_workout]

    test "lists all workouts", %{conn: conn, workout: workout} do
      {:ok, _index_live, html} = live(conn, Routes.workout_index_path(conn, :index))

      assert html =~ "Listing Workouts"
      assert html =~ workout.name
    end

    test "saves new workout", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.workout_index_path(conn, :index))

      assert index_live |> element("a", "New Workout") |> render_click() =~
               "New Workout"

      assert_patch(index_live, Routes.workout_index_path(conn, :new))

      assert index_live
             |> form("#workout-form", workout: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#workout-form", workout: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.workout_index_path(conn, :index))

      assert html =~ "Workout created successfully"
      assert html =~ "some name"
    end

    test "updates workout in listing", %{conn: conn, workout: workout} do
      {:ok, index_live, _html} = live(conn, Routes.workout_index_path(conn, :index))

      assert index_live |> element("#workout-#{workout.id} a", "Edit") |> render_click() =~
               "Edit Workout"

      assert_patch(index_live, Routes.workout_index_path(conn, :edit, workout))

      assert index_live
             |> form("#workout-form", workout: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#workout-form", workout: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.workout_index_path(conn, :index))

      assert html =~ "Workout updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes workout in listing", %{conn: conn, workout: workout} do
      {:ok, index_live, _html} = live(conn, Routes.workout_index_path(conn, :index))

      assert index_live |> element("#workout-#{workout.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#workout-#{workout.id}")
    end
  end

  describe "Show" do
    setup [:create_workout]

    test "displays workout", %{conn: conn, workout: workout} do
      {:ok, _show_live, html} = live(conn, Routes.workout_show_path(conn, :show, workout))

      assert html =~ "Show Workout"
      assert html =~ workout.name
    end

    test "updates workout within modal", %{conn: conn, workout: workout} do
      {:ok, show_live, _html} = live(conn, Routes.workout_show_path(conn, :show, workout))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Workout"

      assert_patch(show_live, Routes.workout_show_path(conn, :edit, workout))

      assert show_live
             |> form("#workout-form", workout: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#workout-form", workout: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.workout_show_path(conn, :show, workout))

      assert html =~ "Workout updated successfully"
      assert html =~ "some updated name"
    end
  end
end
