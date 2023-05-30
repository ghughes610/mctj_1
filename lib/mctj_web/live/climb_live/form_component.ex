defmodule MctjWeb.ClimbLive.FormComponent do
  use MctjWeb, :live_component

  alias Mctj.Workouts

  @impl true
  def mount(params, session, socket), do: {:ok, assign_defaults(session, socket)}

end
