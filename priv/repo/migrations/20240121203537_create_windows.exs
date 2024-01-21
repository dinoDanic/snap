defmodule Snap.Repo.Migrations.CreateWindows do
  use Ecto.Migration

  def change do
    create table(:windows) do
      add :name, :string
      add :session_id, references(:sessions, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:windows, [:session_id])
  end
end
