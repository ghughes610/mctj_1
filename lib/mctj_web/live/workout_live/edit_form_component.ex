defmodule MctjWeb.WorkoutLive.EditFormComponent do
  use MctjWeb, :live_component

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(
       socket,
       workout: socket.assigns.workout,
       exercise_id: socket.assigns.exercise_id
     )}
  end

  def build_weight_list(), do: List.flatten(["trx", "body weight", Enum.to_list(1..300)])
end
