defmodule Snap.Panes.Pane do
  use Ecto.Schema
  import Ecto.Changeset

  schema "panes" do
    field :name, :string
    belongs_to :window, Snap.Windows.Window

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(pane, attrs) do
    pane
    |> cast(attrs, [:name, :window_id])
    |> validate_required([:name, :window_id])
  end
end
