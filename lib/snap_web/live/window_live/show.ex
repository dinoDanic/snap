defmodule SnapWeb.WindowLive.Show do
  use SnapWeb, :live_view

  alias Snap.Windows

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:window, Windows.get_window!(id))}
  end

  defp page_title(:show), do: "Show Window"
  defp page_title(:edit), do: "Edit Window"
end
