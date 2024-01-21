defmodule Snap.Windows.Window do
  use Ecto.Schema
  import Ecto.Changeset

  schema "windows" do
    field :name, :string

    belongs_to :session, Snap.Sessions.Session

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(window, attrs) do
    window
    |> cast(attrs, [:name, :session_id])
    |> validate_required([:name, :session_id])
  end
end
