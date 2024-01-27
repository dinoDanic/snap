defmodule Snap.Notes.Note do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notes" do
    field :note, :string
    belongs_to :pane, Snap.Panes.Pane

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:note])
    |> validate_required([:note])
  end
end
