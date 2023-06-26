defmodule MctjWeb.ClimbLive.Index do
  import Ecto.Query
  use MctjWeb, :live_view

  alias Mctj.ApplicationConfig
  alias Mctj.Climbs
  alias Mctj.Climbs.Climb
  alias Mctj.UserClimbs
  alias Mctj.UserClimbs.UserClimb
  alias Mctj.WeatherFetcher.Weather


  @impl true
  def mount(_params, session, socket) do
    grades = ApplicationConfig.get_config_by_service_name!("grades_list")
    socket =
      assign_defaults(session, socket)
      |> assign(
        :items,
        Climbs.list_climbs()
      )
      |> assign(:grades, grades.metadata["grades"])

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

  def handle_event("log_climb", %{"climb_id" => climb_id, "sent" => "true"} = params, socket) do
    case UserClimbs.find_user_climb(socket.assigns.current_user.id, climb_id) do
      [] ->
        climb = Climbs.get_climb!(climb_id)

        attrs = %{
          user_id: socket.assigns.current_user.id,
          climb_id: climb_id,
          metadata: %{
            "send_session_notes" => %{"notes" => params["notes"], "weather" => Weather.fetch_current_weather(climb.zip)},
            "climb_zip" => climb.zip
          },
          sessions: 1,
          send_date: Timex.now()
        }

        UserClimbs.create_user_climb(attrs)

      [climb | _] ->
        UserClimbs.update_user_climb(climb, build_updated_climb(climb, params))
    end

    {:noreply, assign(socket, live_action: nil)}
  end

  def handle_event("log_climb", %{"climb_id" => climb_id, "sent" => "false"} = params, socket) do
    case UserClimbs.find_user_climb(socket.assigns.current_user.id, climb_id) do
      [] ->
        climb = Climbs.get_climb!(climb_id)

        attrs = %{
          user_id: socket.assigns.current_user.id,
          climb_id: climb_id,
          metadata: %{
            "session_1_notes" => %{"notes" => params["notes"], "weather" => Weather.fetch_current_weather(climb.zip)},
            "climb_zip" => climb.zip
          },
          sessions: 1,
          send_date: nil
        }

        UserClimbs.create_user_climb(attrs)

      [climb | _] ->
        UserClimbs.update_user_climb(climb, build_updated_climb(climb, params))
    end

    {:noreply, assign(socket, live_action: nil)}
  end

  defp build_updated_climb(%UserClimb{send_date: nil} = climb, %{"sent" => "true"} = params) do
    current_session = climb.sessions + 1

    attrs =
      climb
      |> Map.from_struct()
      |> Map.put(:sessions, current_session)

    new_metadata =
      Map.put(climb.metadata, "send_session_notes", %{"notes" => params["notes"], "weather" => Weather.fetch_current_weather(climb.metadata["climb_zip"]) })
      |> Map.put("repeat_dates", [])

    attrs =
      Map.put(attrs, :metadata, new_metadata)
      |> Map.merge(%{send_date: Timex.now()})
  end

  defp build_updated_climb(%UserClimb{send_date: nil} = climb, %{"sent" => "false"} = params) do
    current_session = climb.sessions + 1

    attrs =
      climb
      |> Map.from_struct()
      |> Map.put(:sessions, current_session)

    new_metadata = Map.put(climb.metadata, "session_#{current_session}_notes", %{"notes" => params["notes"], "weather" => Weather.fetch_current_weather(climb.metadata["climb_zip"]) })

    attrs = Map.put(attrs, :metadata, new_metadata)
  end

  defp build_updated_climb(
         %UserClimb{send_date: send_date, metadata: %{"repeat_dates" => []}} = climb,
         params
       ) do
    new_metadata = Map.put(climb.metadata, "repeat_dates", [Timex.now()])

    Map.put(Map.from_struct(climb), :metadata, new_metadata)
  end

  defp build_updated_climb(
         %UserClimb{send_date: send_date, metadata: metadata} = climb,
         %{"sent" => "true"} = params
       ) do
    new_metadata =
      Map.put(climb.metadata, "repeat_dates", climb.metadata["repeat_dates"] ++ [Timex.now()])

    Map.put(Map.from_struct(climb), :metadata, new_metadata)
  end

  defp build_updated_climb(
         %UserClimb{send_date: send_date, metadata: metadata} = climb,
         %{"sent" => "false"} = params
       ) do
    Map.from_struct(climb)
  end
end
