defmodule Snap.NotesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snap.Notes` context.
  """

  @doc """
  Generate a note.
  """
  def note_fixture(attrs \\ %{}) do
    {:ok, note} =
      attrs
      |> Enum.into(%{
        note: "some note"
      })
      |> Snap.Notes.create_note()

    note
  end
end
