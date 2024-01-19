defmodule Snap.SessionsUsers.SessionUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sessions_users" do
    belongs_to :session, Snap.Sessions.Session
    belongs_to :user, Snap.Users.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:session_id, :user_id])
    |> validate_required([:session_id, :user_id])
  end
end
