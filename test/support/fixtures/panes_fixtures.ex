defmodule Snap.PanesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snap.Panes` context.
  """

  @doc """
  Generate a pane.
  """
  def pane_fixture(attrs \\ %{}) do
    {:ok, pane} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Snap.Panes.create_pane()

    pane
  end
end
