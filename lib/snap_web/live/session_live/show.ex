defmodule SnapWeb.SessionLive.Show do
  alias Snap.Windows
  alias Plug.Session
  alias Snap.Repo
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
  def handle_params(%{"id" => session_id}, _, socket) do
    session = Sessions.get_session(session_id) |> Repo.preload(:windows)

    case session.windows do
      [first_window | _] ->
        window_id = first_window.id
        {:noreply, push_patch(socket, to: "/session/#{session_id}/window/#{window_id}")}

      [] ->
        {:noreply, socket}
    end
  end

  @impl true
  def handle_params(%{"session_id" => session_id, "window_id" => window_id}, _, socket) do
    # if connected?(socket), do: Phoenix.PubSub.subscribe(Snap.PubSub, "sessions")

    user = socket.assigns.current_user
    sessions = Sessions.get_user_sessions(user.id)

    session = Sessions.get_session(session_id) |> Repo.preload(:windows)

    case session do
      nil ->
        {:noreply, push_patch(socket, to: "/")}

      session ->
        %{windows: windows} = session

        windows_to_svelte =
          Enum.map(windows, fn %Snap.Windows.Window{id: id, name: name} ->
            %{id: id, name: name}
          end)

        IO.inspect(windows_to_svelte)
        session_to_svelte = %{id: session.id, name: session.name}

        {:noreply,
         socket
         |> assign(:windows, windows_to_svelte)
         |> assign(:active_session, session_to_svelte)
         |> assign(:active_window_id, window_id)}
    end
  end

  @impl true
  def handle_event("invite_session", %{"email" => email}, socket) do
    session_id = socket.assigns.active_session.id
    Sessions.invite_user_to_session(email, session_id)
    {:noreply, socket}
  end

  @impl true
  def handle_event("change_window", %{"window_id" => window_id}, socket) do
    session_id = socket.assigns.active_session.id
    {:noreply, push_patch(socket, to: "/session/#{session_id}/window/#{window_id}")}
  end

  @impl true
  def handle_event("delete_session", _unsigned_params, socket) do
    active_session = socket.assigns.active_session

    case(Sessions.delete_session(active_session.id)) do
      {:ok, _session} ->
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

  @impl true
  def handle_event("create_window", %{"window_name" => window_name}, socket) do
    IO.puts(~c"create window")
    IO.inspect(window_name)
    active_session = socket.assigns.active_session
    session = Sessions.get_session(active_session.id)

    case Windows.create_window(%{name: window_name}, session) do
      {:ok, window} ->
        {:noreply, push_patch(socket, to: "/session/#{active_session.id}/window/#{window.id}")}

      _ ->
        IO.puts(~c"handle this")
        {:noreply, socket}
    end
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
