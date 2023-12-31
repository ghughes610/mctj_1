defmodule Mctj.Users do
  import Ecto.Query, warn: false
  alias Mctj.Repo

  alias Mctj.Users.FingerLog

  def list_finger_logs do
    Repo.all(FingerLog)
  end

  def get_finger_log!(id), do: Repo.get!(FingerLog, id)

  def create_finger_log(attrs \\ %{}) do
    %FingerLog{}
    |> FingerLog.changeset(attrs)
    |> Repo.insert()
  end

  def update_finger_log(%FingerLog{} = finger_log, attrs) do
    finger_log
    |> FingerLog.changeset(attrs)
    |> Repo.update()
  end

  def delete_finger_log(%FingerLog{} = finger_log) do
    Repo.delete(finger_log)
  end

  def change_finger_log(%FingerLog{} = finger_log, attrs \\ %{}) do
    FingerLog.changeset(finger_log, attrs)
  end
end
