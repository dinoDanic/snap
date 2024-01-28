defmodule SnapWeb.V2.WindowLive.Index do
  alias SnapWeb.V2.WindowLive.HandleParams
  alias SnapWeb.V2.WindowLive.HandleEvents
  use SnapWeb, :app_live_view
  use LiveSvelte.Components

  @impl true
  def render(assigns) do
    ~H"""
    <.svelte name="v2/window/window" props={%{win: @window}} class="h-full" />
    """
  end

  @impl true
  def handle_params(%{"session_id" => session_id, "window_id" => window_id}, _uri, socket) do
    HandleParams.index(session_id, window_id, socket)
  end

  @impl true
  def handle_event("go_to_pane", %{"pane_id" => pane_id}, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("create_session", _unsigned_params, socket) do
    {:noreply, push_navigate(socket, to: "/v2/s/new")}
  end

  @impl true
  def handle_event("delete_session", _unsigned_params, socket) do
    HandleEvents.delete_session(socket)
  end

  @impl true
  def handle_event("create_window", %{"window_name" => window_name}, socket) do
    HandleEvents.create_window(window_name, socket)
  end

  @impl true
  def handle_event("change_window", %{"window_id" => window_id}, socket) do
    session_id = socket.assigns.session.id
    {:noreply, push_patch(socket, to: "/v2/s/#{session_id}/w/#{window_id}")}
  end

  @impl true
  def handle_event("delete_window", _unsigned_params, socket) do
    HandleEvents.delete_window(socket)
  end
end
