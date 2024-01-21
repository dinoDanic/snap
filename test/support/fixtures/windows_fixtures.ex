defmodule Snap.WindowsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snap.Windows` context.
  """

  @doc """
  Generate a window.
  """
  def window_fixture(attrs \\ %{}) do
    {:ok, window} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Snap.Windows.create_window()

    window
  end
end
