defmodule Mctj.ClimbsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mctj.Climbs` context.
  """

  @doc """
  Generate a climb.
  """
  def climb_fixture(attrs \\ %{}) do
    {:ok, climb} =
      attrs
      |> Enum.into(%{
        bolt_count: 42,
        grade: "some grade",
        height: 42,
        name: "some name"
      })
      |> Mctj.Climbs.create_climb()

    climb
  end
end
