defmodule Mctj.AreasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mctj.Areas` context.
  """

  @doc """
  Generate a area.
  """
  def area_fixture(attrs \\ %{}) do
    {:ok, area} =
      attrs
      |> Enum.into(%{
        hike_time: 42,
        location: "some location",
        name: "some name",
        sun_exposure: "some sun_exposure"
      })
      |> Mctj.Areas.create_area()

    area
  end
end
