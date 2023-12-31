defmodule MctjWeb.CommonComponents.WorkoutShowCardComponent do
  use MctjWeb, :view

  def workout_show_card_component(assigns) do
    ~L"""
     <%= for circuit <- assigns.workout.exercises do %>
      <div class="bg-white my-5">
        <div class="flex justify-center pt-3 text-xl font-semibold leading-8">Circuit <%= elem(circuit, 0) %></div>
        <div class="flex justify-between bg-white  ring-1 ring-gray-200 xl:p-8 lg:mt-8 lg:rounded-r-none">
          <%= for exercise <- elem(circuit, 1) do %>
            <div class="mx-5">
              <div class="flex items-center justify-between gap-x-4">
                <h3 class="text-lg font-semibold"><%= exercise.name %></h3>
              </div>
              <p class="mt-6 ml-2 flex items-baseline gap-x-1">
                <span class="text-sm font-semibold leading-6 text-gray-600">Reps:</span>
                <span class="text-4xl font-bold tracking-tight text-gray-900"> <%= exercise.reps %></span>
              </p>
              <p class="mt-6 ml-2 flex items-baseline gap-x-1">
                <span class="text-sm font-semibold leading-6 text-gray-600">Weight:</span>
                <span class="text-4xl font-bold tracking-tight text-gray-900"> <%= exercise.weight %></span>
              </p>
              <%= if exercise.metadata["is_fingers"] do %>
                <p class="mt-6 ml-2 flex items-baseline gap-x-1">
                  <span class="text-sm font-semibold leading-6 text-gray-600">Edge Size:</span>
                  <span class="text-2xl font-bold tracking-tight text-gray-900"> <%= exercise.metadata["edge_size"] %></span>
                </p>
              <% end %>
              <p class="mt-6 ml-2 flex items-baseline gap-x-1">
                <span class="text-sm font-semibold leading-6 text-gray-600">Sets:</span>
                <span class="text-4xl font-bold tracking-tight text-gray-900"><%= exercise.metadata["completed_sets"] %>/<%= assigns.workout.sets %></span>
              </p>


              <%= if exercise.metadata["completed_sets"] < assigns.workout.sets do %>
                <p class="mt-6 ml-2 flex items-baseline gap-x-1">
                  <button type="button" phx-click="complete_set" phx-value-id="<%= exercise.id %>" class="relative -ml-px inline-flex items-center bg-green-100 px-3 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-10 mx-1">Complete set</button>
                </p>
                <% else %>
                <p class="mt-6 ml-2 flex items-baseline gap-x-1">
                  <button type="button"class="relative -ml-px inline-flex items-center bg-green-100 px-3 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-10 mx-1">Done</button>
                </p>
              <% end %>


              <p class="mt-6 ml-2 flex items-baseline gap-x-1">
                <button type="button" phx-click="delete" phx-value-id="<%= exercise.id %>" class="relative -ml-px inline-flex items-center bg-red-100 px-3 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-10 mx-1">Delete</button>
              </p>
            </div>
          <% end %>
        </div>
      </div>
    <% end %>
    """
  end
end
