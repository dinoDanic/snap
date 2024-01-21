defmodule SnapWeb.SessionLive.New do
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
        {:noreply, push_navigate(socket, to: "/session/#{session.id}")}

      {:error, _changeset} ->
        # socket =
        #   socket
        #   |> assign(:form_errors, [%{name: "3"}])

        {:noreply, socket}

      _ ->
        IO.puts(~c"ah shit")
        {:noreply, socket}
    end
  end

  def handle_event("increment", _unsigned_params, socket) do
    {:noreply, assign(socket, :number, socket.assigns.number + 1)}
  end
end
