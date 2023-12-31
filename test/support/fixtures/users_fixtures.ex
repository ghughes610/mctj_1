defmodule Mctj.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mctj.Users` context.
  """

  @doc """
  Generate a finger_log.
  """
  def finger_log_fixture(attrs \\ %{}) do
    {:ok, finger_log} =
      attrs
      |> Enum.into(%{
        position: "some position",
        set: 42,
        exercise: "some exercise",
        average_left_hand_pull: 42,
        average_right_hand_pull: 42,
        max_left_hand_pull: 42,
        max_right_hand_pull: 42,
        time_on: 42,
        time_off: 42,
        reps: 42,
        rest_time: 42
      })
      |> Mctj.Users.create_finger_log()

    finger_log
  end
end
