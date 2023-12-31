defmodule Mctj.Users.FingerLog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "finger_logs" do
    field :position, :string
    field :set, :integer
    field :exercise, :string
    field :average_left_hand_pull, :integer
    field :average_right_hand_pull, :integer
    field :max_left_hand_pull, :integer
    field :max_right_hand_pull, :integer
    field :time_on, :integer
    field :time_off, :integer
    field :reps, :integer
    field :rest_time, :integer
    field :workout_id, :id

    timestamps()
  end

  @doc false
  def changeset(finger_log, attrs) do
    finger_log
    |> cast(attrs, [:exercise, :position, :average_left_hand_pull, :average_right_hand_pull, :max_left_hand_pull, :max_right_hand_pull, :time_on, :time_off, :reps, :set, :rest_time, :workout_id])
    |> validate_required([:exercise, :position, :average_left_hand_pull, :average_right_hand_pull, :max_left_hand_pull, :max_right_hand_pull, :time_on, :time_off, :reps, :set, :rest_time, :workout_id
    ])
  end
end
