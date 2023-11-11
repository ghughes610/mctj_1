defmodule MctjWeb.CommonComponents.PageComponents do
  use MctjWeb, :view

  def workout_show_card_component(assigns) do
    ~L"""
    <%= for circuit <- assigns.workout.exercises do %>
      <div class="bg-white my-5">
        <div class="flex justify-center pt-3 text-xl font-semibold leading-8">Circuit <%= elem(circuit, 0) %></div>
        <div class="flex justify-between bg-white  ring-1 ring-gray-200 xl:p-10 lg:mt-8 lg:rounded-r-none">
          <%= for exercise <- elem(circuit, 1) do %>
            <div class="">
              <div class="flex items-center justify-between gap-x-4">
                <h3 id="tier-startup" class="text-lg font-semibold leading-8"><%= exercise.name %></h3>
              </div>
              <p class="mt-6 ml-2 flex items-baseline gap-x-1">
                <span class="text-sm font-semibold leading-6 text-gray-600">weight:</span>
                <span class="text-4xl font-bold tracking-tight text-gray-900"> <%= exercise.weight %></span>
              </p>
              <ul role="list" class="mt-8 space-y-3 text-sm leading-6 text-gray-600">
                <li class="flex gap-x-3">
                  <svg class="h-6 w-5 flex-none text-indigo-600" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                    <path fill-rule="evenodd" d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z" clip-rule="evenodd" />
                  </svg>
                  25 products
                </li>
                <li class="flex gap-x-3">
                  <svg class="h-6 w-5 flex-none text-indigo-600" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                    <path fill-rule="evenodd" d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z" clip-rule="evenodd" />
                  </svg>
                  Up to 10,000 subscribers
                </li>
                <li class="flex gap-x-3">
                  <svg class="h-6 w-5 flex-none text-indigo-600" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                    <path fill-rule="evenodd" d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z" clip-rule="evenodd" />
                  </svg>
                  Advanced analytics
                </li>
                <li class="flex gap-x-3">
                  <svg class="h-6 w-5 flex-none text-indigo-600" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                    <path fill-rule="evenodd" d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z" clip-rule="evenodd" />
                  </svg>
                  24-hour support response time
                </li>
                <li class="flex gap-x-3">
                  <svg class="h-6 w-5 flex-none text-indigo-600" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                    <path fill-rule="evenodd" d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z" clip-rule="evenodd" />
                  </svg>
                  Marketing automations
                </li>
              </ul>
            </div>
          <% end %>
        </div>
      </div>
    <% end %>
    """
  end
end
