defmodule Snap.Repo.Migrations.CreatePanes do
  use Ecto.Migration

  def change do
    create table(:panes) do
      add :name, :string
      add :window_id, references(:windows, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:panes, [:window_id])
  end
end
