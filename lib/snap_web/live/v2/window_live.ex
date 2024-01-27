defmodule SnapWeb.V2.WindowLive do
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

  # <SnapWeb.V2.Components.Window.render window={@window} />

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
      Enum.map(session.windows, fn %Snap.Windows.Window{id: id, name: name} ->
        %{id: id, name: name}
      end)

    panes_to_svelte =
      Enum.map(window.panes, fn %Pane{id: id, name: name} -> %{id: id, name: name} end)

    session_to_svelte = %{id: session.id, name: session.name, windows: windows_to_svelte}

    window_to_svelte = %{id: window.id, name: window.name, panes: panes_to_svelte}

    IO.inspect(window_to_svelte)

    socket =
      socket
      |> assign(:session, session_to_svelte)
      |> assign(:window, window_to_svelte)
      |> assign(:page, String.to_integer(window_id))

    {:noreply, socket}
  end

  defp load_session(session_id) do
    Sessions.get_session(session_id)
    |> Repo.preload(windows: :panes)
  end
end
