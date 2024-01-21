defmodule SnapWeb.WindowLive.Index do
  use SnapWeb, :live_view

  alias Snap.Windows
  alias Snap.Windows.Window

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :windows, Windows.list_windows())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Window")
    |> assign(:window, Windows.get_window!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Window")
    |> assign(:window, %Window{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Windows")
    |> assign(:window, nil)
  end

  @impl true
  def handle_info({SnapWeb.WindowLive.FormComponent, {:saved, window}}, socket) do
    {:noreply, stream_insert(socket, :windows, window)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    window = Windows.get_window!(id)
    {:ok, _} = Windows.delete_window(window)

    {:noreply, stream_delete(socket, :windows, window)}
  end
end
