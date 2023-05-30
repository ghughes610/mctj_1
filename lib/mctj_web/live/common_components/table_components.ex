defmodule MctjWeb.Live.ComponentsLive.TableComponents do
  use MctjWeb, :view

  def dynamic_table_head(assigns) do
    ~H"""
    <thead class="bg-white">
      <tr>
        <th scope="col" class="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-6">Name</th>
        <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Grade</th>
        <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Bolt Count</th>
        <th scope="col" class="px-3 py-3.5 text-right text-sm font-semibold text-gray-900"><%= Enum.count(@items) %> climbs</th>
      </tr>
    </thead>
    """
  end

  def dynamic_table(assigns) do
    ~H"""
    <%= for i <- @items do %>
        <tr class="border-t border-gray-200">
          <td class="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6"><%= i.name %></td>
          <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500"><%= i.grade %></td>
          <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
            <%= if is_nil(i.bolt_count) do %>
            N/A
            <% else %>
              <%= i.bolt_count %>
            <% end %>
          </td>
          <td class="flex flex-row p-2 whitespace-nowrap px-3 py-4 text-sm text-gray-500 hover:cursor-pointer" phx-click="log_climb_modal" phx-value-id={i.id}><p class="rounded-full bg-blue-300 hover:bg-blue-500 hover:text-gray-900 px-3">Log Climb</p></td>
        </tr>
    <% end %>
    """
  end
end
