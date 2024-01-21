defmodule Snap.Repo.Migrations.AddUniqueIndexToSessionsUsers do
  use Ecto.Migration

  def change do
    create unique_index(:sessions_users, [:session_id, :user_id],
             name: :unique_session_user_combination
           )
  end
end
