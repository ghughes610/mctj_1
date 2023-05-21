defmodule Mctj.ClimbsTest do
  use Mctj.DataCase

  alias Mctj.Climbs

  describe "climbs" do
    alias Mctj.Climbs.Climb

    import Mctj.ClimbsFixtures

    @invalid_attrs %{bolt_count: nil, grade: nil, height: nil, name: nil}

    test "list_climbs/0 returns all climbs" do
      climb = climb_fixture()
      assert Climbs.list_climbs() == [climb]
    end

    test "get_climb!/1 returns the climb with given id" do
      climb = climb_fixture()
      assert Climbs.get_climb!(climb.id) == climb
    end

    test "create_climb/1 with valid data creates a climb" do
      valid_attrs = %{bolt_count: 42, grade: "some grade", height: 42, name: "some name"}

      assert {:ok, %Climb{} = climb} = Climbs.create_climb(valid_attrs)
      assert climb.bolt_count == 42
      assert climb.grade == "some grade"
      assert climb.height == 42
      assert climb.name == "some name"
    end

    test "create_climb/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Climbs.create_climb(@invalid_attrs)
    end

    test "update_climb/2 with valid data updates the climb" do
      climb = climb_fixture()

      update_attrs = %{
        bolt_count: 43,
        grade: "some updated grade",
        height: 43,
        name: "some updated name"
      }

      assert {:ok, %Climb{} = climb} = Climbs.update_climb(climb, update_attrs)
      assert climb.bolt_count == 43
      assert climb.grade == "some updated grade"
      assert climb.height == 43
      assert climb.name == "some updated name"
    end

    test "update_climb/2 with invalid data returns error changeset" do
      climb = climb_fixture()
      assert {:error, %Ecto.Changeset{}} = Climbs.update_climb(climb, @invalid_attrs)
      assert climb == Climbs.get_climb!(climb.id)
    end

    test "delete_climb/1 deletes the climb" do
      climb = climb_fixture()
      assert {:ok, %Climb{}} = Climbs.delete_climb(climb)
      assert_raise Ecto.NoResultsError, fn -> Climbs.get_climb!(climb.id) end
    end

    test "change_climb/1 returns a climb changeset" do
      climb = climb_fixture()
      assert %Ecto.Changeset{} = Climbs.change_climb(climb)
    end
  end
end
