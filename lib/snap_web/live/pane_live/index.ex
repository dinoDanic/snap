defmodule SnapWeb.PaneLive.Index do
  use SnapWeb, :live_view

  alias Snap.Panes
  alias Snap.Panes.Pane

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :panes, Panes.list_panes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Pane")
    |> assign(:pane, Panes.get_pane!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Pane")
    |> assign(:pane, %Pane{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Panes")
    |> assign(:pane, nil)
  end

  @impl true
  def handle_info({SnapWeb.PaneLive.FormComponent, {:saved, pane}}, socket) do
    {:noreply, stream_insert(socket, :panes, pane)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    pane = Panes.get_pane!(id)
    {:ok, _} = Panes.delete_pane(pane)

    {:noreply, stream_delete(socket, :panes, pane)}
  end
end
