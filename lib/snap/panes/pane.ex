defmodule Snap.Panes.Pane do
  use Ecto.Schema
  import Ecto.Changeset

  schema "panes" do
    field :name, :string
    belongs_to :window, Snap.Windows.Window
    has_many(:notes, Snap.Notes.Note, preload_order: [desc: :id])

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(pane, attrs) do
    pane
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
