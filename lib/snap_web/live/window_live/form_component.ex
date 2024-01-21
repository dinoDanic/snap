defmodule SnapWeb.WindowLive.FormComponent do
  use SnapWeb, :live_component

  alias Snap.Windows

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage window records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="window-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Window</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{window: window} = assigns, socket) do
    changeset = Windows.change_window(window)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"window" => window_params}, socket) do
    changeset =
      socket.assigns.window
      |> Windows.change_window(window_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"window" => window_params}, socket) do
    save_window(socket, socket.assigns.action, window_params)
  end

  defp save_window(socket, :edit, window_params) do
    case Windows.update_window(socket.assigns.window, window_params) do
      {:ok, window} ->
        notify_parent({:saved, window})

        {:noreply,
         socket
         |> put_flash(:info, "Window updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_window(socket, :new, window_params) do
    case Windows.create_window(window_params) do
      {:ok, window} ->
        notify_parent({:saved, window})

        {:noreply,
         socket
         |> put_flash(:info, "Window created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
