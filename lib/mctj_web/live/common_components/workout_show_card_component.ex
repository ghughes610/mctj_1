defmodule MctjWeb.CommonComponents.PageComponents do
  use MctjWeb, :view

  def workout_show_card_component(assigns) do
    ~L"""
    <%= for circuit <- assigns.workout.exercises do %>
      <div class="bg-white my-5">
        <div class="flex justify-center pt-3 text-xl font-semibold leading-8">Circuit <%= elem(circuit, 0) %></div>
        <div class="flex justify-center text-xl font-semibold leading-8">Sets <%= assigns.workout.sets %></div>
        <div class="flex justify-between bg-white  ring-1 ring-gray-200 xl:p-10 lg:mt-8 lg:rounded-r-none">
          <%= for exercise <- elem(circuit, 1) do %>
            <div class="">
              <div class="flex items-center justify-between gap-x-4">
                <h3 class="text-lg font-semibold leading-8"><%= exercise.name %></h3>
              </div>
              <p class="mt-6 ml-2 flex items-baseline gap-x-1">
                <span class="text-sm font-semibold leading-6 text-gray-600">Reps:</span>
                <span class="text-4xl font-bold tracking-tight text-gray-900"> <%= exercise.reps %></span>
              </p>
              <p class="mt-6 ml-2 flex items-baseline gap-x-1">
                <span class="text-sm font-semibold leading-6 text-gray-600">Weight:</span>
                <span class="text-4xl font-bold tracking-tight text-gray-900"> <%= exercise.weight %></span>
              </p>
            </div>
          <% end %>
        </div>
      </div>
    <% end %>
    """
  end
end
