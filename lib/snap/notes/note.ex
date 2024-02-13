defmodule Snap.Notes.Note do
  use Ecto.Schema
  import Ecto.Changeset

  # @type t :: do we need this if we hance schema?

  schema "notes" do
    field :note, :string
    field :class, {:array, :string}

    belongs_to :pane, Snap.Panes.Pane

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:note, :class])
    |> validate_required([])
  end
end
