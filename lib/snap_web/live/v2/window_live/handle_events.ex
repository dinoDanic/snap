defmodule SnapWeb.V2.WindowLive.HandleEvents do
  alias Snap.Notes
  alias Snap.Windows
  alias Snap.Sessions
  use SnapWeb, :app_live_view

  def delete_session(socket) do
    active_session = socket.assigns.session

    case(Sessions.delete_session(active_session.id)) do
      {:ok, _session} ->
        {:noreply, redirect(socket, to: "/")}

      _ ->
        {:noreply, redirect(socket, to: "/")}
    end
  end

  def create_window(window_name, socket) do
    active_session = socket.assigns.session
    session = Sessions.get_session(active_session.id)

    case Windows.create_window(%{name: window_name}, session) do
      {:ok, window} ->
        update_active_session =
          Map.update!(active_session, :windows, fn windows ->
            windows ++ [%{id: window.id, name: window.name, panes: []}]
          end)

        update_socket = assign(socket, :session, update_active_session)
        {:noreply, push_patch(update_socket, to: "/v2/s/#{active_session.id}/w/#{window.id}")}

      _ ->
        {:noreply, socket}
    end
  end

  def delete_window(socket) do
    active_window = socket.assigns.window
    session = socket.assigns.session

    updated_windows =
      Enum.filter(session.windows, fn window ->
        window.id != active_window.id
      end)

    update_socket = assign(socket, :session, %{session | windows: updated_windows})

    Task.start(fn ->
      window = Windows.get_window!(active_window.id)
      Windows.delete_window(window)
    end)

    first_window = Enum.at(updated_windows, 0)

    case first_window do
      nil ->
        {:noreply, redirect(update_socket, to: "/")}

      window ->
        IO.inspect(window)
        {:noreply, push_patch(update_socket, to: "/v2/s/#{session.id}/w/#{window.id}")}
    end
  end

  def go_to_pane(pane_id, socket) do
    session = socket.assigns.session
    window = socket.assigns.window
    {:noreply, push_patch(socket, to: "/v2/s/#{session.id}/w/#{window.id}/p/#{pane_id}")}
  end

  def update_note(%{"id" => note_id, "note" => new_note}, socket) do
    IO.inspect(socket.assigns)
    active_pane = socket.assigns.pane

    update_notes =
      Enum.map(active_pane.notes, fn note ->
        if note.id == note_id do
          %{note | note: new_note}
        else
          note
        end
      end)

    update_pane = %{active_pane | notes: update_notes}

    update_socket = assign(socket, :pane, update_pane)

    Task.start(fn ->
      get_note = Notes.get_note!(note_id)
      Notes.update_note(get_note, %{note: new_note})
    end)

    {:noreply, update_socket}
  end

  def invite_session(email, socket) do
    session_id = socket.assigns.session.id

    case Sessions.invite_user_to_session(email, session_id) do
      {:ok, user} ->
        socket =
          socket
          |> Phoenix.LiveView.put_flash(:ok, "Invited #{user.email} to session")

        {:noreply, socket}

      {:error, message} ->
        socket =
          socket
          |> Phoenix.LiveView.put_flash(:error, message)

        {:noreply, socket}
    end
  end

  def logout(socket) do
    {:noreply, push_redirect(socket, to: "/users/log_out")}
  end
end
