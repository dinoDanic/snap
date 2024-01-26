defmodule SnapWeb.V2.WindowLive do
  alias Snap.Repo
  alias Snap.Sessions
  use SnapWeb, :app_live_view
  use LiveSvelte.Components

  @impl true
  def render(assigns) do
    ~H"""
    <SnapWeb.V2.Components.Window.render window={@window} />
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

    IO.inspect(window)

    socket =
      socket
      |> assign(:session, session)
      |> assign(:window, window)
      |> assign(:page, String.to_integer(window_id))

    {:noreply, socket}
  end

  defp load_session(session_id) do
    Sessions.get_session(session_id)
    |> Repo.preload(windows: :panes)
  end
end
