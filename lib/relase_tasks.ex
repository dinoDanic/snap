defmodule RelaseTasks do
  def migrate do
    {:ok, _} = Application.ensure_all_started(:snap)

    path = Application.app_dir(:snap, "priv/repo/migrations")

    Ecto.Migrator.run(Snap.Repo, path, :up, all: true)

    :init.stop()
  end
end
