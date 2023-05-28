defmodule MctjWeb.ClimbLive.Index do
  use MctjWeb, :live_view

  alias Mctj.Climbs
  alias Mctj.Climbs.Climb

  @grades [
    "5.13a",
    "5.13b",
    "5.13c",
    "5.13d",
    "5.14a",
    "5.14b",
    "5.14c",
    "5.14d",
    "5.15a"
  ]
  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)

    socket =
      assign(
        socket,
        :items,
        Climbs.list_climbs()
      )
      |> assign(:grades, @grades)

    {:ok, socket}
  end

  def handle_event("get_by_grade", %{"grade" => grade}, socket) do
    climbs = Climbs.get_climbs_by_grade(grade)

    {:noreply, assign(socket, items: climbs)}
  end
end
