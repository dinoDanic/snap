defmodule SnapWeb.HomeLive.Index do
  alias Hex.API.User
  use SnapWeb, :live_view

  def mount(_params, _session, socket) do
    IO.puts(~c"ovo je socket u rootu")
    IO.inspect(socket)

    user = socket.assigns.current_user

    hasSession = check_if_user_has_sessions(user)

    case hasSession do
      true -> IO.puts(~c"ima")
      false -> IO.puts(~c"nema")
    end

    {:ok, socket}
  end

  defp check_if_user_has_sessions(user) do
    IO.inspect(user)
    true
  end
end
