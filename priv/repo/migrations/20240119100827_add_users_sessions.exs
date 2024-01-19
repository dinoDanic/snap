defmodule Snap.Repo.Migrations.AddUsersSessions do
  use Ecto.Migration

  def change do
    create table(:sessions_users) do
      add :session_id, references(:sessions, on_delete: :nothing, on_update: :nothing)
      add :user_id, references(:users, on_delete: :nothing, on_update: :nothing)

      timestamps(type: :utc_datetime)
    end
  end
end
