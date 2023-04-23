defmodule Mctj.AreasTest do
  use Mctj.DataCase

  alias Mctj.Areas

  describe "areas" do
    alias Mctj.Areas.Area

    import Mctj.AreasFixtures

    @invalid_attrs %{hike_time: nil, location: nil, name: nil, sun_exposure: nil}

    test "list_areas/0 returns all areas" do
      area = area_fixture()
      assert Areas.list_areas() == [area]
    end

    test "get_area!/1 returns the area with given id" do
      area = area_fixture()
      assert Areas.get_area!(area.id) == area
    end

    test "create_area/1 with valid data creates a area" do
      valid_attrs = %{hike_time: 42, location: "some location", name: "some name", sun_exposure: "some sun_exposure"}

      assert {:ok, %Area{} = area} = Areas.create_area(valid_attrs)
      assert area.hike_time == 42
      assert area.location == "some location"
      assert area.name == "some name"
      assert area.sun_exposure == "some sun_exposure"
    end

    test "create_area/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Areas.create_area(@invalid_attrs)
    end

    test "update_area/2 with valid data updates the area" do
      area = area_fixture()
      update_attrs = %{hike_time: 43, location: "some updated location", name: "some updated name", sun_exposure: "some updated sun_exposure"}

      assert {:ok, %Area{} = area} = Areas.update_area(area, update_attrs)
      assert area.hike_time == 43
      assert area.location == "some updated location"
      assert area.name == "some updated name"
      assert area.sun_exposure == "some updated sun_exposure"
    end

    test "update_area/2 with invalid data returns error changeset" do
      area = area_fixture()
      assert {:error, %Ecto.Changeset{}} = Areas.update_area(area, @invalid_attrs)
      assert area == Areas.get_area!(area.id)
    end

    test "delete_area/1 deletes the area" do
      area = area_fixture()
      assert {:ok, %Area{}} = Areas.delete_area(area)
      assert_raise Ecto.NoResultsError, fn -> Areas.get_area!(area.id) end
    end

    test "change_area/1 returns a area changeset" do
      area = area_fixture()
      assert %Ecto.Changeset{} = Areas.change_area(area)
    end
  end
end
