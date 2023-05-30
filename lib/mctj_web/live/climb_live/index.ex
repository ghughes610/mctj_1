defmodule MctjWeb.ClimbLive.Index do
  import Ecto.Query
  use MctjWeb, :live_view

  alias Mctj.Climbs
  alias Mctj.Climbs.Climb
  alias Mctj.UserClimbs

  @grades [
    "all",
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
    socket =
      assign_defaults(session, socket)
      |> assign(
        :items,
        Climbs.list_climbs()
      )
      |> assign(:grades, @grades)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket), do: {:noreply, socket}

  def handle_event("get_by_grade", %{"grade" => "all"}, socket),
    do: {:noreply, assign(socket, items: Climbs.list_climbs())}

  def handle_event("get_by_grade", %{"grade" => grade}, socket),
    do: {:noreply, assign(socket, items: Climbs.get_climbs_by_grade(grade))}

  def handle_event("log_climb_modal", params, socket),
    do:
      {:noreply,
       assign(socket, live_action: :new) |> assign(:climb, Climbs.get_climb!(params["id"]))}

  def handle_event("log_climb", %{"climb_id" => climb_id} = params, socket) do
    user_climb = UserClimbs.find_user_climb(socket.assigns.current_user.id, climb_id)

    case user_climb do
      [] ->
        attrs = %{
          user_id: socket.assigns.current_user.id,
          climb_id: climb_id,
          metadata: %{"session_1_notes" => params["notes"]},
          sessions: 1
        }

        UserClimbs.create_user_climb(attrs)

      [climb | _] ->
        current_session = climb.sessions + 1

        attrs =
          climb
          |> Map.from_struct()
          |> Map.put(:sessions, current_session)

        new_metadata =
          Map.put(climb.metadata, "session_#{current_session}_notes", params["notes"])

        attrs =
          attrs
          |> Map.put(:metadata, new_metadata)

        UserClimbs.update_user_climb(climb, attrs)
    end

    {:noreply, assign(socket, live_action: nil)}
  end
end
