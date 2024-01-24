defmodule SnapWeb.V1.PaneLive.Show do
  use SnapWeb, :live_view

  alias Snap.Panes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:pane, Panes.get_pane!(id))}
  end

  defp page_title(:show), do: "Show Pane"
  defp page_title(:edit), do: "Edit Pane"
end
