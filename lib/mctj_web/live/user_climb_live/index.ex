defmodule MctjWeb.UserClimbLive.Index do
  use MctjWeb, :live_view

  alias Mctj.UserClimbs

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)

    climbs = UserClimbs.list_user_climbs(socket.assigns.current_user.id)

    {:ok, assign(socket, climbs: climbs)}
  end
end
