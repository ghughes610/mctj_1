defmodule MctjWeb.ExerciseLive.FormComponent do
  use MctjWeb, :live_component

  alias Mctj.Exercises

  @impl true
  def mount(params, session, socket) do
    
    {:ok, socket}
  end

  def handle_event("save", %{"exercise" => exercise_params}, socket) do
    socket = assign(socket, action: :new)
    save_exercise(socket, socket.assigns.action, exercise_params)
  end

  defp save_exercise(socket, :edit, exercise_params) do
    case Exercises.update_exercise(socket.assigns.exercise, exercise_params) do
      {:ok, _exercise} ->
        {:noreply,
         socket
         |> put_flash(:info, "Exercise updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_exercise(socket, :new, exercise_params) do
    case Exercises.create_exercise(exercise_params) do
      {:ok, _exercise} ->
        {:noreply,
         socket
         |> put_flash(:info, "Exercise created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
