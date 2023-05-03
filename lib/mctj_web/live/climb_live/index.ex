defmodule MctjWeb.ClimbLive.Index do
  use MctjWeb, :live_view

  alias Mctj.Climbs
  alias Mctj.Climbs.Climb

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    socket = assign(
      socket,
      # :climbs, list_climbs(),
      :items, list_climbs()
  )

    {:ok, socket}
  end

  defp list_climbs do
    Climbs.list_climbs()
  end

  def handle_event("get_by_grade", params, socket) do
    climbs = Climbs.get_climbs_by_grade(params["grade"])
    {:noreply, assign(socket, items: climbs)}
  end
end
