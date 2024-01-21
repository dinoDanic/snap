defmodule SnapWeb.SessionLive.New do
  alias Snap.Windows
  alias Snap.Sessions

  use SnapWeb, :live_view
  use LiveSvelte.Components

  def mount(_params, _session, socket) do
    changeset = Sessions.Session.create_changeset(%Sessions.Session{})

    socket =
      socket
      |> assign(:form_errors, [])
      |> assign(:number, 1)
      |> assign(
        :form,
        to_form(changeset)
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.svelte name="sessions/new_session" />
    """
  end

  def handle_event("create", session, socket) do
    %{"name" => name} = session
    # %{"session" => %{"name" => name}} = session
    {:noreply, socket}

    user = socket.assigns.current_user
    #
    case(Sessions.create_session(%{name: name}, user.id)) do
      {:ok, session} ->
        case(Windows.create_window(%{name: "welcome_window"}, session)) do
          {:ok, window} ->
            {:noreply, push_navigate(socket, to: "/session/#{session.id}/window/#{window.id}")}

          {:error, _} ->
            {:noreply, socket}

          _ ->
            {:noreply, socket}
        end

      {:error, _changeset} ->
        # socket =
        #   socket
        #   |> assign(:form_errors, [%{name: "3"}])

        {:noreply, socket}

      _ ->
        {:noreply, socket}
    end
  end
end
