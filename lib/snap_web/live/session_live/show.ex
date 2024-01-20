defmodule SnapWeb.SessionLive.Show do
  alias Snap.Sessions
  use SnapWeb, :session_live_view
  use LiveSvelte.Components

  def render(assigns) do
    ~H"""
    Session <%= @session.id %>
    """
  end

  def mount(params, session, socket) do
    user = socket.assigns.current_user

    {:ok,
     socket
     |> assign(:sessions, Sessions.get_user_sessions(user.id))}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    user = socket.assigns.current_user

    {:noreply,
     socket
     |> assign(:session, Sessions.get_session!(id))
     |> assign(:sessions, Sessions.get_user_sessions(user.id))}
  end

  def handle_event("change_session", %{"session_id" => session_id}, socket) do
    IO.inspect(session_id)
    {:noreply, socket}
  end
end
