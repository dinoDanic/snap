defmodule SnapWeb.V2.HomeLive do
  use SnapWeb, :live_view
  alias Snap.Users.User
  alias Snap.Repo
  use LiveSvelte.Components

  def mount(_params, _session, socket) do
    assigned_user = socket.assigns.current_user

    result = check_if_user_has_sessions(assigned_user)

    case result do
      {true, sessions} ->
        [first | _rest] = sessions
        {:ok, push_navigate(socket, to: "/v2/s/#{first.id}")}

      {false} ->
        {:ok, push_navigate(socket, to: "/v2/s/new")}
    end
  end

  defp check_if_user_has_sessions(assigned_user) do
    user = Repo.get(User, assigned_user.id)

    case Repo.preload(user, :sessions) do
      %User{sessions: []} -> {false}
      %User{sessions: sessions} -> {true, sessions}
    end
  end

  def render(assigns) do
    ~H"""

    """
  end
end
