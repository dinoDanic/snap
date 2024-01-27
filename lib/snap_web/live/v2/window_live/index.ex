defmodule SnapWeb.V2.WindowLive.Index do
  alias SnapWeb.V2.Components.Window
  alias Snap.Windows
  alias Snap.Panes.Pane
  alias Snap.Repo
  alias Snap.Sessions
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
    parsed_session_id = String.to_integer(session_id)
    current_session = socket.assigns[:session]

    session =
      if current_session && current_session.id == parsed_session_id do
        current_session
      else
        load_session(session_id)
      end

    window =
      Enum.find(session.windows, fn w -> w.id == String.to_integer(window_id) end)

    windows_to_svelte =
      Enum.map(session.windows, fn %{id: id, name: name, panes: panes} ->
        %{id: id, name: name, panes: panes}
      end)

    panes_to_svelte =
      Enum.map(window.panes, fn %{id: id, name: name} -> %{id: id, name: name} end)

    session_to_svelte = %{id: session.id, name: session.name, windows: windows_to_svelte}

    window_to_svelte = %{id: window.id, name: window.name, panes: panes_to_svelte}

    socket =
      socket
      |> assign(:session, session_to_svelte)
      |> assign(:window, window_to_svelte)
      |> assign(:page, String.to_integer(window_id))

    IO.inspect(socket.assigns)

    {:noreply, socket}
  end

  def handle_event("go_to_pane", %{"pane_id" => pane_id}, socket) do
    {:noreply, socket}
  end

  def handle_event("create_session", _unsigned_params, socket) do
    {:noreply, push_navigate(socket, to: "/v2/s/new")}
  end

  @impl true
  def handle_event("delete_session", _unsigned_params, socket) do
    active_session = socket.assigns.session

    case(Sessions.delete_session(active_session.id)) do
      {:ok, _session} ->
        {:noreply, redirect(socket, to: "/")}

      _ ->
        {:noreply, redirect(socket, to: "/")}
    end
  end

  @impl true
  def handle_event("create_window", %{"window_name" => window_name}, socket) do
    active_session = socket.assigns.session
    session = Sessions.get_session(active_session.id)

    case Windows.create_window(%{name: window_name}, session) do
      {:ok, window} ->
        update_active_session =
          Map.update!(active_session, :windows, fn windows ->
            windows ++ [%{id: window.id, name: window.name, panes: []}]
          end)

        update_socket = assign(socket, :session, update_active_session)
        {:noreply, push_patch(update_socket, to: "/v2/s/#{active_session.id}/w/#{window.id}")}

      _ ->
        {:noreply, socket}
    end
  end

  @impl true
  def handle_event("change_window", %{"window_id" => window_id}, socket) do
    session_id = socket.assigns.session.id
    {:noreply, push_patch(socket, to: "/v2/s/#{session_id}/w/#{window_id}")}
    # {:noreply, socket}
  end

  defp load_session(session_id) do
    Sessions.get_session(session_id)
    |> Repo.preload(windows: :panes)
  end
end
