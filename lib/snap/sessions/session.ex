defmodule Snap.Sessions.Session do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sessions" do
    field :name, :string

    belongs_to :admin, Snap.Users.User

    many_to_many :users, Snap.Users.User,
      join_through: Snap.SessionsUsers.SessionUser,
      on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def create_changeset(session, attrs \\ %{}) do
    session
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
