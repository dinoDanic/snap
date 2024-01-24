defmodule SnapWeb.V1.PaneLive.FormComponent do
  use SnapWeb, :live_component

  alias Snap.Panes

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage pane records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="pane-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Pane</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{pane: pane} = assigns, socket) do
    changeset = Panes.change_pane(pane)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"pane" => pane_params}, socket) do
    changeset =
      socket.assigns.pane
      |> Panes.change_pane(pane_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"pane" => pane_params}, socket) do
    save_pane(socket, socket.assigns.action, pane_params)
  end

  defp save_pane(socket, :edit, pane_params) do
    case Panes.update_pane(socket.assigns.pane, pane_params) do
      {:ok, pane} ->
        notify_parent({:saved, pane})

        {:noreply,
         socket
         |> put_flash(:info, "Pane updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_pane(socket, :new, pane_params) do
    case Panes.create_pane(pane_params) do
      {:ok, pane} ->
        notify_parent({:saved, pane})

        {:noreply,
         socket
         |> put_flash(:info, "Pane created successfully")
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
