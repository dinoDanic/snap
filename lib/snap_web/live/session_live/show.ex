defmodule SnapWeb.SessionLive.Show do
  alias Snap.Sessions
  use SnapWeb, :session_live_view
  use LiveSvelte.Components

  def render(assigns) do
    ~H"""
    <div class="flex h-full w-full items-center justify-center">
      Session <%= @active_session.name %>
    </div>
    """
  end

  def mount(params, session, socket) do
    user = socket.assigns.current_user

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    user = socket.assigns.current_user
    sessions = Sessions.get_user_sessions(user.id)

    case Sessions.get_session(id) do
      nil ->
        {:noreply, push_patch(socket, to: "/")}

      session ->
        sessions_to_svelte =
          Enum.map(sessions, fn %Snap.Sessions.Session{id: id, name: name} ->
            %{id: id, name: name}
          end)

        session_to_svelte = %{id: session.id, name: session.name}

        IO.inspect(session)
        IO.inspect(session_to_svelte)

        {:noreply,
         socket
         |> assign(:active_session, session_to_svelte)
         |> assign(:sessions, sessions_to_svelte)
         |> assign(:number, id)}
    end
  end

  def handle_event("change_session", %{"session_id" => session_id}, socket) do
    {:noreply, push_patch(socket, to: "/session/#{session_id}")}
  end

  def handle_event("delete_session", _unsigned_params, socket) do
    user = socket.assigns.current_user
    active_session = socket.assigns.active_session

    case(Sessions.delete_session(active_session.id)) do
      {:ok, _session} ->
        IO.puts(~c"udem?>")
        {:noreply, redirect(socket, to: "/")}

      _ ->
        {:noreply, redirect(socket, to: "/")}
    end
  end

  def handle_event("create_session", _unsigned_params, socket) do
    user = socket.assigns.current_user

    case(Sessions.create_session(%{name: "new session"}, user.id)) do
      {:ok, session} ->
        {:noreply, push_patch(socket, to: "/session/#{session.id}")}
    end
  end
end
