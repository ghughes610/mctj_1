defmodule MctjWeb.CommonComponents.WorkoutIndexCardComponent do
  use MctjWeb, :view

  def workout_index_card_component(assigns) do
    ~L"""
    <%= for workout <- @workouts do %>
      <div id={"workout-#{workout.id}"} class="p-4 bg-cyan-300 rounded-lg">
            <time class="text-gray-500"><%= Timex.format!(workout.inserted_at, "{0M}/{D}/{YYYY}") %></time>
              <div class="flex flex-row items-center justify-center rounded-full bg-gray-50 py-1.5 px-3 font-medium text-gray-600 whitespace-nowrap">
                <%= workout.type %>
              </div>
            <span class="relative z-10 rounded-full bg-gray-50 py-1.5 px-3 font-medium text-gray-600 hover:bg-red-200">
              <%= link "Delete", to: "#", phx_click: "delete", phx_value_id: workout.id, data: [confirm: "Are you sure?"] %>
            </span>
            </div>
            <div class="group relative">
              <h3 class="mt-3 text-lg font-semibold leading-6 text-gray-900 group-hover:text-gray-500">
                    <%= live_patch "#{workout.name}", to: Routes.live_path(@socket, MctjWeb.WorkoutLive.Show, workout), class: "button" %>
              </h3>
            </div>
            <div class="text-sm flex flex-row justify-center pt-2">
              <div>
                circuits: <%= workout.number_of_circuits %>
              </div>
            </div>
      </div>
      <% end %>
    """
  end
end
