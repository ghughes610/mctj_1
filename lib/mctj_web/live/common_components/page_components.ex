defmodule MctjWeb.CommonComponents.PageComponents do
  use MctjWeb, :view

  def header(assigns) do
    ~H"""
    <h2 class="m-1.5 text-xl font-bold text-base font-medium text-black hover:text-gray-500"><a href="http://localhost:4000/">Training Journal</a></h2>
    """
  end

  def section_header(assigns) do
    ~H"""
    <div class="bg-indigo-500">
      <div class="mx-auto max-w-7xl py-16 px-4 sm:py-24 sm:px-6 lg:px-8">
        <div class="text-center">
          <p class="mt-1 text-4xl font-bold tracking-tight text-gray-900 sm:text-5xl lg:text-6xl">Take control of your team.</p>
          <p class="mx-auto mt-5 max-w-xl text-xl text-gray-500">Start building for free, then add a site plan to go live. Account plans unlock additional features.</p>
        </div>
      </div>
    </div>
    """
  end

  def make_slider(name, min \\ 0, max \\ 10) do
    assigns = %{
      min: min,
      max: max,
      name: name
    }

    ~L"""
    <div class="flex place-content-center text-cyan-50"><%= String.capitalize(@name) |> String.replace("_", " ")  %></div>
    <div class="flex place-content-center">
      <div class="m-2 text-red-500"><%= @min %></div>
        <input type="range" id="volume" name="<%= @name %>" min="<%= @min %>" max="<%= @max %>">
      <div class="m-2 text-green-500"><%= @max %></div>
    </div>
    """
  end

  def make_custom_slider(name, display_name, min \\ 0, max \\ 10) do
    assigns = %{
      min: min,
      max: max,
      name: name,
      display_name: display_name
    }

    ~L"""
    <div class="flex place-content-center text-cyan-50"><%= String.capitalize(@display_name) %></div>
    <div class="flex place-content-center">
      <div class="m-2 text-red-500"><%= @min %></div>
        <input type="range" id="volume" name="<%= @name %>" min="<%= @min %>" max="<%= @max %>">
      <div class="m-2 text-green-500"><%= @max %></div>
    </div>
    """
  end

  def make_text_input(field, display_name \\ nil) do
    assigns = %{
      field: field,
      display_name: display_name
    }

    if display_name == nil do
      ~L"""
      <div>
        <div class="relative my-1.5 rounded-md shadow-sm">
          <input type="text" placeholder="<%= String.capitalize(@field) %>" name="<%= @field %>" class="p-3 block w-full rounded-md border-gray-300 pr-10 focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
        </div>
      </div>
      """
    else
      ~L"""
      <div>
        <div class="relative my-1.5 rounded-md shadow-sm">
          <input type="text" placeholder="<%= @display_name %>" name="<%= @field %>" class="p-3 block w-full rounded-md border-gray-300 pr-10 focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
        </div>
      </div>

      """
    end
  end

  def circuit_card(assigns) do
    ~H"""
      <%= for i <- @items do %>
        <li class="col-span-1 flex rounded-md shadow-sm">
          <div class={["flex-shrink-0 flex items-center justify-center w-16 bg-pink-600 text-white text-sm font-medium rounded-l-md", (if i.id, do: " #{Enum.random([" bg-blue-600", " bg-red-600", "  bg-green-600", "  bg-gray-600"])}", else: " bg-blue-600") ]}>
            <%= link("√",
              to: "#",
              phx_click: "complete_circuit",
              phx_value_id: i.id
              ) %>
          </div>
          <div class="flex flex-1 items-center justify-between truncate rounded-r-md border-t border-r border-b border-gray-200 bg-white">
            <div class="flex-1 truncate px-4 py-2 text-sm">
              <a class="font-medium text-gray-900 hover:text-gray-600">
                          <%= live_patch i.name,
                            to: Routes.live_path(
                            @socket,
                            @module,
                            id: i.id
                          ) %>
                        </a>

              <p class="text-gray-500"><%= Timex.format!(i.inserted_at, "{M}/{D}/{YYYY}") %></p>
              </div>
              <div class="flex-shrink-0 pr-2">
                <button type="button" class="inline-flex h-8 w-8 items-center justify-center rounded-full bg-white bg-transparent text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">
                    <%= link("X",
                            to: "#",
                            phx_click: "delete",
                            phx_value_id: i.id
                    ) %>
                </button>
              </div>
            </div>
          </li>
      <% end %>
    """
  end

  def workout_card(assigns) do
    ~H"""
    <%= for i <- @items do %>
      <li class="col-span-1 flex rounded-md shadow-sm w-96 m-3">

        <div class={["flex-shrink-0 flex items-center justify-center w-20 text-white text-sm font-medium rounded-l-md px-3", (if i.id, do: " #{Enum.random([" bg-gray-900", " bg-purple-700", "  bg-green-900", "  bg-gray-600"])}", else: " bg-blue-600") ]}>
          <%= link(i.type,
            to: "/users/workouts/#{i.id}",
            phx_value_id: i.id
            ) %>

        </div>
          <div class="flex flex-1 items-center justify-between truncate rounded-r-md border-t border-r border-b border-gray-200 bg-white">

          <div class="flex-1 truncate px-4 py-2 text-sm">
            <%= icon_type(i.type, assigns) %>
            <p class="text-gray-500"><%= Timex.format!(i.inserted_at, "{M}/{D}/{YYYY}") %></p>
          </div>
          <div class="flex-shrink-0 pr-2">
            <button type="button" class="inline-flex h-8 w-8 items-center justify-center rounded-full bg-white bg-transparent text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">
            <%= link("X",
            to: "#",
            phx_click: "delete",
            phx_value_id: i.id
            ) %>
            </button>
          </div>
        </div>
      </li>
    <% end %>
    """
  end

  def exercise_card(assigns) do
    ~H"""
    <%= for i <- @items do %>
      <li class="col-span-1 flex rounded-md shadow-sm">

      <div class={["flex-shrink-0 flex items-center justify-center w-16 bg-pink-600 text-white text-sm font-medium rounded-l-md", (if i.id, do: " #{Enum.random([" bg-blue-600", " bg-red-600", "  bg-green-600", "  bg-gray-600"])}", else: " bg-blue-600") ]}>
        <%= link("√",
            to: "#",
            phx_click: "complete_set",
            phx_value_id: i.id
            ) %>
      </div>
            <div class="flex flex-1 items-center justify-between truncate rounded-r-md border-t border-r border-b border-gray-200 bg-white">
            <div class="flex-1 truncate px-4 py-2 text-sm">
              <a class="font-medium text-gray-900 hover:text-gray-600">
              <%= live_patch i.name,
              to: Routes.live_path(
              @socket,
              @module,
              id: i.id
              ) %>
              </a>
              <p class="text-gray-500"><%= i.weight %> lb</p>
              <p class="text-gray-500"><%= i.reps %> reps</p>
              <p class="text-gray-500"><%= i.completed_sets %>/<%= @circuit.sets %> sets complete</p>
            </div>
            <div class="flex-shrink-0 pr-2">
              <button type="button" class="inline-flex h-8 w-8 items-center justify-center rounded-full bg-white bg-transparent text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">
              <%= link("X",
              to: "#",
              phx_click: "delete",
              phx_value_id: i.id
              ) %>
              </button>
            </div>
        </div>
      </li>
    <% end %>
    """
  end

  def nav_menu(assigns) do
    ~H"""
    <div x-data="{ open: false }" @mouseover = "open = true" @click = "open = !open">
      <div
        @mouseover = "open = true"
        class="mr-1 relative text-left">
          <button
            @mouseover = "open = true"
            @keydown.escape.window="open = false"
            class="flex items-center h-8 pl-3 pr-2 border border-black focus:outline-none">
            <span class="text-sm leading-none">
              Navigation
            </span>
            <svg class="w-4 h-4 mt-px ml-2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
            </svg>
          </button>
          <div
            @mouseover.away = "open = false"
            x-cloak
            x-show="open"
            x-transition:enter="transition ease-out duration-100"
            x-transition:enter-start="transform opacity-0 scale-95"
            x-transition:enter-end="transform opacity-100 scale-100"
            x-transition:leave="transition ease-in duration-75"
            x-transition:leave-start="transform opacity-100 scale-100"
            x-transition:leave-end="transform opacity-0 scale-95"
            class="absolute flex flex-col w-40 mt-1 border border-black shadow-xs bg-white">
            <a class="flex items-center h-8 px-3 text-sm hover:bg-gray-200" href="http://localhost:4000/create_workout">Create A Workout</a>
            <a class="flex items-center h-8 px-3 text-sm hover:bg-gray-200" href="http://localhost:4000/search_workouts">Search Workouts</a>
            <a class="flex items-center h-8 px-3 text-sm hover:bg-gray-200" href="http://localhost:4000/exercises">Exercises</a>
          </div>
      </div>
    </div>
    """
  end

  def icon_type(field, assigns) do
    case field do
      "Power Endurance" ->
        ~H"""
        <div class="flex flex-row">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M20.57 14.86L22 13.43L20.57 12L17 15.57L8.43 7L12 3.43L10.57 2L9.14 3.43L7.71 2L5.57 4.14L4.14 2.71L2.71 4.14l1.43 1.43L2 7.71l1.43 1.43L2 10.57L3.43 12L7 8.43L15.57 17L12 20.57L13.43 22l1.43-1.43L16.29 22l2.14-2.14l1.43 1.43l1.43-1.43l-1.43-1.43L22 16.29l-1.43-1.43Z"/></svg>

          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><g fill="currentColor"><path d="M17 4a2 2 0 1 1-4 0a2 2 0 0 1 4 0Z"/><path fill-rule="evenodd" d="M6.21 6.047a5.019 5.019 0 0 1 4.637-.357a1.817 1.817 0 0 1 .569 2.955l-1.654 1.654a.84.84 0 0 0 .056 1.24l.997.83a2.6 2.6 0 0 1 .935 1.998V16a.75.75 0 0 1-1.5 0v-1.633a1.1 1.1 0 0 0-.396-.846l-.996-.83A2.34 2.34 0 0 1 8.7 9.238l1.654-1.654a.317.317 0 0 0-.1-.516a3.518 3.518 0 0 0-3.25.25L4.898 8.637a.75.75 0 0 1-.795-1.272L6.21 6.047ZM11.75 10a.75.75 0 0 1 .75-.75h3a.75.75 0 0 1 0 1.5h-3a.75.75 0 0 1-.75-.75Zm-4.22 3.47a.75.75 0 0 1 0 1.06l-.328.329a68.32 68.32 0 0 0-.085.085c-.494.495-.885.886-1.393 1.097c-.509.21-1.061.21-1.76.21l-.12-.001H3a.75.75 0 0 1 0-1.5h.843c.879 0 1.11-.013 1.307-.095c.198-.082.37-.236.991-.857l.329-.328a.75.75 0 0 1 1.06 0Z" clip-rule="evenodd"/><path d="M3.087 22h16.402a2.511 2.511 0 1 0-.433-4.985l-.163.029L20.033 9v-.003c.053-.35.085-.553.124-.699a.63.63 0 0 1 .04-.115l.006-.012l.002-.001l.01-.007a.635.635 0 0 1 .114-.046c.145-.046.346-.087.695-.157l1.123-.225a.75.75 0 1 0-.294-1.47l-1.157.23c-.303.062-.589.119-.823.194a1.73 1.73 0 0 0-.755.447c-.227.238-.34.51-.41.776c-.064.237-.107.525-.153.832l-.005.034l-1.21 8.538L2.9 19.843A1.087 1.087 0 0 0 3.086 22Z"/></g></svg>
        </div>
        """
      "Power" ->
        ~H"""
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M20.57 14.86L22 13.43L20.57 12L17 15.57L8.43 7L12 3.43L10.57 2L9.14 3.43L7.71 2L5.57 4.14L4.14 2.71L2.71 4.14l1.43 1.43L2 7.71l1.43 1.43L2 10.57L3.43 12L7 8.43L15.57 17L12 20.57L13.43 22l1.43-1.43L16.29 22l2.14-2.14l1.43 1.43l1.43-1.43l-1.43-1.43L22 16.29l-1.43-1.43Z"/></svg>
        """
      "Endurance" ->
        ~H"""
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><g fill="currentColor"><path d="M17 4a2 2 0 1 1-4 0a2 2 0 0 1 4 0Z"/><path fill-rule="evenodd" d="M6.21 6.047a5.019 5.019 0 0 1 4.637-.357a1.817 1.817 0 0 1 .569 2.955l-1.654 1.654a.84.84 0 0 0 .056 1.24l.997.83a2.6 2.6 0 0 1 .935 1.998V16a.75.75 0 0 1-1.5 0v-1.633a1.1 1.1 0 0 0-.396-.846l-.996-.83A2.34 2.34 0 0 1 8.7 9.238l1.654-1.654a.317.317 0 0 0-.1-.516a3.518 3.518 0 0 0-3.25.25L4.898 8.637a.75.75 0 0 1-.795-1.272L6.21 6.047ZM11.75 10a.75.75 0 0 1 .75-.75h3a.75.75 0 0 1 0 1.5h-3a.75.75 0 0 1-.75-.75Zm-4.22 3.47a.75.75 0 0 1 0 1.06l-.328.329a68.32 68.32 0 0 0-.085.085c-.494.495-.885.886-1.393 1.097c-.509.21-1.061.21-1.76.21l-.12-.001H3a.75.75 0 0 1 0-1.5h.843c.879 0 1.11-.013 1.307-.095c.198-.082.37-.236.991-.857l.329-.328a.75.75 0 0 1 1.06 0Z" clip-rule="evenodd"/><path d="M3.087 22h16.402a2.511 2.511 0 1 0-.433-4.985l-.163.029L20.033 9v-.003c.053-.35.085-.553.124-.699a.63.63 0 0 1 .04-.115l.006-.012l.002-.001l.01-.007a.635.635 0 0 1 .114-.046c.145-.046.346-.087.695-.157l1.123-.225a.75.75 0 1 0-.294-1.47l-1.157.23c-.303.062-.589.119-.823.194a1.73 1.73 0 0 0-.755.447c-.227.238-.34.51-.41.776c-.064.237-.107.525-.153.832l-.005.034l-1.21 8.538L2.9 19.843A1.087 1.087 0 0 0 3.086 22Z"/></g></svg>
        """
      _ -> ~H"""
      <span class="text-2xl">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><g fill="currentColor"><path d="M17 4a2 2 0 1 1-4 0a2 2 0 0 1 4 0Z"/><path fill-rule="evenodd" d="M6.21 6.047a5.019 5.019 0 0 1 4.637-.357a1.817 1.817 0 0 1 .569 2.955l-1.654 1.654a.84.84 0 0 0 .056 1.24l.997.83a2.6 2.6 0 0 1 .935 1.998V16a.75.75 0 0 1-1.5 0v-1.633a1.1 1.1 0 0 0-.396-.846l-.996-.83A2.34 2.34 0 0 1 8.7 9.238l1.654-1.654a.317.317 0 0 0-.1-.516a3.518 3.518 0 0 0-3.25.25L4.898 8.637a.75.75 0 0 1-.795-1.272L6.21 6.047ZM11.75 10a.75.75 0 0 1 .75-.75h3a.75.75 0 0 1 0 1.5h-3a.75.75 0 0 1-.75-.75Zm-4.22 3.47a.75.75 0 0 1 0 1.06l-.328.329a68.32 68.32 0 0 0-.085.085c-.494.495-.885.886-1.393 1.097c-.509.21-1.061.21-1.76.21l-.12-.001H3a.75.75 0 0 1 0-1.5h.843c.879 0 1.11-.013 1.307-.095c.198-.082.37-.236.991-.857l.329-.328a.75.75 0 0 1 1.06 0Z" clip-rule="evenodd"/><path d="M3.087 22h16.402a2.511 2.511 0 1 0-.433-4.985l-.163.029L20.033 9v-.003c.053-.35.085-.553.124-.699a.63.63 0 0 1 .04-.115l.006-.012l.002-.001l.01-.007a.635.635 0 0 1 .114-.046c.145-.046.346-.087.695-.157l1.123-.225a.75.75 0 1 0-.294-1.47l-1.157.23c-.303.062-.589.119-.823.194a1.73 1.73 0 0 0-.755.447c-.227.238-.34.51-.41.776c-.064.237-.107.525-.153.832l-.005.034l-1.21 8.538L2.9 19.843A1.087 1.087 0 0 0 3.086 22Z"/></g></svg>
      </span>
      """
    end
  end

  def make_whiteboard_button(assigns) do
    ~H"""
    <span class="mt-2 ml-1 isolate inline-flex rounded-md shadow-sm">
      <button type="button" class="relative inline-flex items-center rounded-md border border-gray-300 bg-white px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 focus:z-10 focus:border-indigo-500 focus:outline-none focus:ring-1 focus:ring-indigo-500">
        <!-- Heroicon name: mini/bookmark -->
        <svg class="h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
        <path fill-rule="evenodd" d="M12.79 5.23a.75.75 0 01-.02 1.06L8.832 10l3.938 3.71a.75.75 0 11-1.04 1.08l-4.5-4.25a.75.75 0 010-1.08l4.5-4.25a.75.75 0 011.06.02z" clip-rule="evenodd" /></svg>

      </button>
    </span>
    """
  end

  def random_color_div(field) do
    assigns = %{
      id: true,
      field: field
    }

    ~L"""
    <div class={["flex-shrink-0 flex items-center justify-center w-16 bg-pink-600 text-white text-sm font-medium rounded-l-md", (if @id, do: " #{Enum.random([" bg-blue-600", " bg-red-600", "  bg-green-600", "  bg-gray-600"])}", else: " bg-blue-600") ]}>
      <%= @field %>
    </div>
    """
  end

  def full_workout_card(assigns) do
    ~H"""
      <ul role="list" class="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
        <li class="col-span-1 divide-y divide-gray-200 rounded-lg bg-white shadow">
          <div class="flex w-full items-center justify-between space-x-6 p-6">
            <div class="flex-1 truncate">
              <div class="flex items-center space-x-3">
                <h3 class="truncate text-sm font-medium text-gray-900">Jane Cooper</h3>
                <span class="inline-block flex-shrink-0 rounded-full bg-green-100 px-2 py-0.5 text-xs font-medium text-green-800">Admin</span>
              </div>
              <p class="mt-1 truncate text-sm text-gray-500">Regional Paradigm Technician</p>
            </div>
            <img class="h-10 w-10 flex-shrink-0 rounded-full bg-gray-300" src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=4&w=256&h=256&q=60" alt="">
          </div>
          <div>
            <div class="-mt-px flex divide-x divide-gray-200">
              <div class="flex w-0 flex-1">
                <a href="mailto:janecooper@example.com" class="relative -mr-px inline-flex w-0 flex-1 items-center justify-center rounded-bl-lg border border-transparent py-4 text-sm font-medium text-gray-700 hover:text-gray-500">
                  <!-- Heroicon name: mini/envelope -->
                  <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                    <path d="M3 4a2 2 0 00-2 2v1.161l8.441 4.221a1.25 1.25 0 001.118 0L19 7.162V6a2 2 0 00-2-2H3z" />
                    <path d="M19 8.839l-7.77 3.885a2.75 2.75 0 01-2.46 0L1 8.839V14a2 2 0 002 2h14a2 2 0 002-2V8.839z" />
                  </svg>
                  <span class="ml-3">Email</span>
                </a>
              </div>
              <div class="-ml-px flex w-0 flex-1">
                <a href="tel:+1-202-555-0170" class="relative inline-flex w-0 flex-1 items-center justify-center rounded-br-lg border border-transparent py-4 text-sm font-medium text-gray-700 hover:text-gray-500">
                  <!-- Heroicon name: mini/phone -->
                  <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                    <path fill-rule="evenodd" d="M2 3.5A1.5 1.5 0 013.5 2h1.148a1.5 1.5 0 011.465 1.175l.716 3.223a1.5 1.5 0 01-1.052 1.767l-.933.267c-.41.117-.643.555-.48.95a11.542 11.542 0 006.254 6.254c.395.163.833-.07.95-.48l.267-.933a1.5 1.5 0 011.767-1.052l3.223.716A1.5 1.5 0 0118 15.352V16.5a1.5 1.5 0 01-1.5 1.5H15c-1.149 0-2.263-.15-3.326-.43A13.022 13.022 0 012.43 8.326 13.019 13.019 0 012 5V3.5z" clip-rule="evenodd" />
                  </svg>
                  <span class="ml-3">Call</span>
                </a>
              </div>
            </div>
          </div>
        </li>
      </ul>
    """
  end
end
