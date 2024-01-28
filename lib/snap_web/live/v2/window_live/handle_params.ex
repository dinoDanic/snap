defmodule SnapWeb.V2.WindowLive.HandleParams do
  alias Snap.Panes
  alias Snap.Repo
  alias Snap.Sessions
  use SnapWeb, :app_live_view

  def index(session_id, window_id, socket) do
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
        %{id: id, name: name, panes: panes_to_svelte(panes)}
      end)

    session_to_svelte = %{id: session.id, name: session.name, windows: windows_to_svelte}

    window_to_svelte = %{id: window.id, name: window.name, panes: panes_to_svelte(window.panes)}

    socket =
      socket
      |> assign(:session, session_to_svelte)
      |> assign(:window, window_to_svelte)
      |> assign(:page, :window)

    socket
  end

  defp load_session(session_id) do
    Sessions.get_session(session_id)
    |> Repo.preload(windows: :panes)
  end

  defp panes_to_svelte(panes) do
    update_panes = Enum.map(panes, fn pane -> %{name: pane.name, id: pane.id} end)
  end

  def pane_id(session_id, window_id, pane_id, socket) do
    base_socket = index(session_id, window_id, socket)
    pane = Panes.get_pane!(pane_id) |> Repo.preload(:notes)

    notes_to_svelte = Enum.map(pane.notes, fn note -> %{note: note.note, id: note.id} end)

    pane_to_svelte = %{id: pane.id, name: pane.name, notes: notes_to_svelte}

    socket = base_socket |> assign(:pane, pane_to_svelte) |> assign(:page, :pane)

    {:noreply, socket}
  end
end
