defmodule Snap.Repo do
  use Ecto.Repo,
    otp_app: :snap,
    adapter: Ecto.Adapters.Postgres
end
