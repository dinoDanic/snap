defmodule Snap.Repo.Migrations.AddClassesToNotes do
  use Ecto.Migration

  def change do
    alter table(:notes) do
      add :class, {:array, :string}, using: "string_to_array(class, ',')"
    end
  end
end
