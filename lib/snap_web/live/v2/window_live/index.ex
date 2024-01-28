defmodule SnapWeb.V2.WindowLive.Index do
  alias SnapWeb.V2.WindowLive
  alias SnapWeb.V2.WindowLive.HandleParams
  alias SnapWeb.V2.WindowLive.HandleEvents
  use SnapWeb, :app_live_view
  use LiveSvelte.Components

  @impl true
  def render(assigns) do
    IO.inspect(assigns)

    ~H"""
    <%= if @page == :window do %>
      <.svelte name="v2/window/window" props={%{win: @window}} class="h-full" />
    <% end %>
    <%= if @page == :pane do %>
      <.svelte name="v2/pane/pane" props={%{pane: @pane}} />
    <% end %>
    """
  end

  @impl true
  def handle_params(%{"session_id" => s_id, "window_id" => w_id, "pane_id" => p_id}, _uri, socket) do
    HandleParams.pane_id(s_id, w_id, p_id, socket)
  end

  @impl true
  def handle_params(%{"session_id" => s_id, "window_id" => w_id}, _uri, socket) do
    index_socket = HandleParams.index(s_id, w_id, socket)
    {:noreply, index_socket}
  end

  @impl true
  def handle_event("go_to_pane", %{"pane_id" => pane_id}, socket) do
    HandleEvents.go_to_pane(pane_id, socket)
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
