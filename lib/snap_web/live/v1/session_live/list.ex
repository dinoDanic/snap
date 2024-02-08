defmodule SnapWeb.V1.SessionLive.List do
  use SnapWeb, :live_view

  use LiveSvelte.Components

  alias Snap.Sessions

  @impl true
  def render(assigns) do
    ~H"""
    <.svelte
      name="v1/sessions/list/list"
      props={%{private_sessions: @private_sessions, public_sessions: @public_sessions}}
    />
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    current_user = socket.assigns.current_user
    sessions = Sessions.get_user_sessions(current_user.id) |> Snap.Repo.preload(:users)
    IO.inspect(sessions)

    {private_sessions, public_sessions} =
      Enum.reduce(sessions, {[], []}, fn session, {private_acc, public_acc} ->
        users_simplified =
          Enum.map(session.users, fn %Snap.Users.User{id: user_id, email: email} ->
            %{id: user_id, email: email}
          end)

        session_map = %{id: session.id, name: session.name, users: users_simplified}

        if Enum.all?(session.users, fn user -> user.id == current_user.id end) do
          {[session_map | private_acc], public_acc}
        else
          {private_acc, [session_map | public_acc]}
        end
      end)

    socket =
      socket
      |> assign(:private_sessions, private_sessions)
      |> assign(:public_sessions, public_sessions)

    {:ok, socket}
  end

  @impl true
  def handle_event("redirect", %{"session_id" => session_id}, socket) do
    {:noreply, push_navigate(socket, to: "/v1/session/#{session_id}")}
  end
end
