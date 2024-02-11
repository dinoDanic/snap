defmodule SnapWeb.V2.WindowLive.Index do
  alias SnapWeb.V2.WindowLive.HandleParams
  alias SnapWeb.V2.WindowLive.HandleEvents
  use SnapWeb, :app_live_view
  use LiveSvelte.Components

  @impl true
  def render(assigns) do
    ~H"""
    <%= if @page == :window do %>
      <.svelte name="v2/window/window" props={%{win: @window}} class="h-full" />
    <% end %>
    <%= if @page == :pane do %>
      <.svelte name="v2/pane/pane" props={%{pane: @pane, command_open: @command_open}} />
    <% end %>
    """
  end

  @impl true
  def handle_params(
        %{"session_id" => s_id, "window_id" => w_id, "pane_id" => p_id},
        _uri,
        socket
      ),
      do: HandleParams.pane_page(s_id, w_id, p_id, socket)

  @impl true
  def handle_params(%{"session_id" => s_id, "window_id" => w_id}, _uri, socket),
    do: HandleParams.window_page(s_id, w_id, socket)

  @impl true
  def handle_event("go_to_pane", %{"pane_id" => pane_id}, socket),
    do: HandleEvents.go_to_pane(pane_id, socket)

  @impl true
  def handle_event("create_session", _unsigned_params, socket),
    do: {:noreply, push_navigate(socket, to: "/v2/s/new")}

  @impl true
  def handle_event("delete_session", _unsigned_params, socket),
    do: HandleEvents.delete_session(socket)

  @impl true
  def handle_event("create_window", %{"window_name" => window_name}, socket),
    do: HandleEvents.create_window(window_name, socket)

  @impl true
  def handle_event("change_window", %{"window_id" => window_id}, socket) do
    session_id = socket.assigns.session.id
    {:noreply, push_patch(socket, to: "/v2/s/#{session_id}/w/#{window_id}")}
  end

  @impl true
  def handle_event("delete_window", _unsigned_params, socket),
    do: HandleEvents.delete_window(socket)

  @impl true
  def handle_event("update_note", note, socket), do: HandleEvents.update_note(note, socket)

  @impl true
  def handle_event("invite_session", %{"email" => email}, socket),
    do: HandleEvents.invite_session(email, socket)

  @impl true
  def handle_event("log_out", _params, socket), do: HandleEvents.logout(socket)

  @impl true
  def handle_event("command_open", %{"state" => state}, socket),
    do: HandleEvents.command_open(state, socket)

  @impl true
  def handle_event("add_css_to_note", %{"css" => css, "note_id" => note_id}, socket) do
    HandleEvents.add_css_to_note(css, note_id, socket)
  end
end
