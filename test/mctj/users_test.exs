defmodule Mctj.UsersTest do
  use Mctj.DataCase

  alias Mctj.Users

  describe "finger_logs" do
    alias Mctj.Users.FingerLog

    import Mctj.UsersFixtures

    @invalid_attrs %{position: nil, set: nil, exercise: nil, average_left_hand_pull: nil, average_right_hand_pull: nil, max_left_hand_pull: nil, max_right_hand_pull: nil, time_on: nil, time_off: nil, reps: nil, rest_time: nil}

    test "list_finger_logs/0 returns all finger_logs" do
      finger_log = finger_log_fixture()
      assert Users.list_finger_logs() == [finger_log]
    end

    test "get_finger_log!/1 returns the finger_log with given id" do
      finger_log = finger_log_fixture()
      assert Users.get_finger_log!(finger_log.id) == finger_log
    end

    test "create_finger_log/1 with valid data creates a finger_log" do
      valid_attrs = %{position: "some position", set: 42, exercise: "some exercise", average_left_hand_pull: 42, average_right_hand_pull: 42, max_left_hand_pull: 42, max_right_hand_pull: 42, time_on: 42, time_off: 42, reps: 42, rest_time: 42}

      assert {:ok, %FingerLog{} = finger_log} = Users.create_finger_log(valid_attrs)
      assert finger_log.position == "some position"
      assert finger_log.set == 42
      assert finger_log.exercise == "some exercise"
      assert finger_log.average_left_hand_pull == 42
      assert finger_log.average_right_hand_pull == 42
      assert finger_log.max_left_hand_pull == 42
      assert finger_log.max_right_hand_pull == 42
      assert finger_log.time_on == 42
      assert finger_log.time_off == 42
      assert finger_log.reps == 42
      assert finger_log.rest_time == 42
    end

    test "create_finger_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_finger_log(@invalid_attrs)
    end

    test "update_finger_log/2 with valid data updates the finger_log" do
      finger_log = finger_log_fixture()
      update_attrs = %{position: "some updated position", set: 43, exercise: "some updated exercise", average_left_hand_pull: 43, average_right_hand_pull: 43, max_left_hand_pull: 43, max_right_hand_pull: 43, time_on: 43, time_off: 43, reps: 43, rest_time: 43}

      assert {:ok, %FingerLog{} = finger_log} = Users.update_finger_log(finger_log, update_attrs)
      assert finger_log.position == "some updated position"
      assert finger_log.set == 43
      assert finger_log.exercise == "some updated exercise"
      assert finger_log.average_left_hand_pull == 43
      assert finger_log.average_right_hand_pull == 43
      assert finger_log.max_left_hand_pull == 43
      assert finger_log.max_right_hand_pull == 43
      assert finger_log.time_on == 43
      assert finger_log.time_off == 43
      assert finger_log.reps == 43
      assert finger_log.rest_time == 43
    end

    test "update_finger_log/2 with invalid data returns error changeset" do
      finger_log = finger_log_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_finger_log(finger_log, @invalid_attrs)
      assert finger_log == Users.get_finger_log!(finger_log.id)
    end

    test "delete_finger_log/1 deletes the finger_log" do
      finger_log = finger_log_fixture()
      assert {:ok, %FingerLog{}} = Users.delete_finger_log(finger_log)
      assert_raise Ecto.NoResultsError, fn -> Users.get_finger_log!(finger_log.id) end
    end

    test "change_finger_log/1 returns a finger_log changeset" do
      finger_log = finger_log_fixture()
      assert %Ecto.Changeset{} = Users.change_finger_log(finger_log)
    end
  end
end
