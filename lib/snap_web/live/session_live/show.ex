defmodule SnapWeb.SessionLive.Show do
  use SnapWeb, :session_live_view
  use LiveSvelte.Components

  alias Snap.Sessions

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex h-full w-full items-center justify-center">
      Session <%= @active_session.name %>
    </div>
    """
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    # if connected?(socket), do: Phoenix.PubSub.subscribe(Snap.PubSub, "sessions")

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

        {:noreply,
         socket
         |> assign(:active_session, session_to_svelte)
         |> assign(:sessions, sessions_to_svelte)
         |> assign(:number, id)}
    end
  end

  @impl true
  def handle_event("invite_session", %{"email" => email}, socket) do
    session_id = socket.assigns.active_session.id
    Sessions.invite_user_to_session(email, session_id)
    {:noreply, socket}
  end

  @impl true
  def handle_event("change_session", %{"session_id" => session_id}, socket) do
    {:noreply, push_patch(socket, to: "/session/#{session_id}")}
  end

  @impl true
  def handle_event("delete_session", _unsigned_params, socket) do
    active_session = socket.assigns.active_session

    case(Sessions.delete_session(active_session.id)) do
      {:ok, _session} ->
        IO.puts(~c"udem?>")
        {:noreply, redirect(socket, to: "/")}

      _ ->
        {:noreply, redirect(socket, to: "/")}
    end
  end

  @impl true
  def handle_event("create_session", _unsigned_params, socket) do
    {:noreply, push_navigate(socket, to: "/session/new")}
  end

  @impl true
  def handle_event("list_sessions", _unsigned_params, socket) do
    {:noreply, push_navigate(socket, to: "/session/list")}
  end
end

# Phoenix.PubSub.broadcast(Snap.PubSub, "sessions", {:new, session})

# @impl true
# def handle_info({:new, session}, socket) do
#   user = socket.assigns.user
#   IO.inspect(user.email)
#   IO.puts(~c"ovo je novo right?")
#   {:noreply, update(socket, :sessions, fn sessions -> [sessions | session] end)}
#   # {:noreply, socket}
# end