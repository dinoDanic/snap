defmodule SnapWeb.V2.SessionLive.Index do
  alias Snap.Repo
  use SnapWeb, :live_view

  alias Snap.Sessions
  alias Snap.Windows

  @impl true
  def render(assigns) do
    ~H"""
    bok
    """
  end

  @impl true
  def handle_params(%{"session_id" => session_id}, _, socket) do
    session = Sessions.get_session(session_id) |> Repo.preload(:windows)

    case session.windows do
      [first_window | _] ->
        window_id = first_window.id
        {:noreply, push_patch(socket, to: "/v2/s/#{session_id}/w/#{window_id}")}

      [] ->
        case Windows.create_window(%{name: "welcome_window"}, session) do
          {:ok, window} ->
            {:noreply, push_patch(socket, to: "/v2/s/#{session.id}/w/#{window.id}")}

          {:error} ->
            {:noreply, push_patch(socket, to: "/v2/s/")}

          _ ->
            {:noreply, push_patch(socket, to: "/v2/")}
        end
    end
  end
end
