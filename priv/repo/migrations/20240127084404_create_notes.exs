defmodule Snap.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :note, :text
      add :pane_id, references(:panes, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:notes, [:pane_id])
  end
end
