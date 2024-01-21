defmodule SnapWeb.HomeLive.Index do
  alias Snap.Users.User
  alias Snap.Repo
  use SnapWeb, :live_view
  use LiveSvelte.Components

  def mount(_params, _session, socket) do
    assigned_user = socket.assigns.current_user

    result = check_if_user_has_sessions(assigned_user)

    case result do
      {true, sessions} ->
        [first | _rest] = sessions
        {:ok, push_navigate(socket, to: "/session/#{first.id}")}

      {false} ->
        {:ok, push_navigate(socket, to: "/session/new")}
    end
  end

  defp check_if_user_has_sessions(assigned_user) do
    user = Repo.get(User, assigned_user.id)

    case Repo.preload(user, :sessions) do
      %User{sessions: sessions} when length(sessions) > 0 -> {true, sessions}
      _ -> {false}
    end
  end

  def render(assigns) do
    ~H"""

    """
  end

  def handle_event("continue", _, socket) do
    {:noreply, push_navigate(socket, to: "/session/new")}
  end
end
