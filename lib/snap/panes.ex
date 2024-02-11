defmodule Snap.Panes do
  @moduledoc """
  The Panes context.
  """

  import Ecto.Query, warn: false
  alias Snap.Notes
  alias Snap.Repo

  alias Snap.Panes.Pane

  @doc """
  Returns the list of panes.

  ## Examples

      iex> list_panes()
      [%Pane{}, ...]

  """
  def list_panes do
    Repo.all(Pane)
  end

  @doc """
  Gets a single pane.

  Raises `Ecto.NoResultsError` if the Pane does not exist.

  ## Examples

      iex> get_pane!(123)
      %Pane{}

      iex> get_pane!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pane!(id), do: Repo.get!(Pane, id)

  @doc """
  Creates a pane.

  ## Examples

      iex> create_pane(%{field: value})
      {:ok, %Pane{}}

      iex> create_pane(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  # def create_pane(attrs \\ %{}, window) do
  #   %Pane{}
  #   |> Pane.changeset(attrs)
  #   |> Ecto.Changeset.put_assoc(:window, window)
  #   |> Repo.insert()
  # end

  def create_pane(attrs \\ %{}, window) do
    pane_changeset =
      %Pane{}
      |> Pane.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:window, window)

    Repo.transaction(fn ->
      {:ok, pane} = Repo.insert(pane_changeset)
      note_attrs = %{"note" => "Title", "class" => ["text-3xl", "font-bold"]}
      Notes.create_note(note_attrs, pane)

      1..4
      |> Enum.each(fn _ ->
        Notes.create_note(%{}, pane)
      end)
    end)
  end

  @doc """
  Updates a pane.

  ## Examples

      iex> update_pane(pane, %{field: new_value})
      {:ok, %Pane{}}

      iex> update_pane(pane, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pane(%Pane{} = pane, attrs) do
    pane
    |> Pane.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pane.

  ## Examples

      iex> delete_pane(pane)
      {:ok, %Pane{}}

      iex> delete_pane(pane)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pane(%Pane{} = pane) do
    Repo.delete(pane)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pane changes.

  ## Examples

      iex> change_pane(pane)
      %Ecto.Changeset{data: %Pane{}}

  """
  def change_pane(%Pane{} = pane, attrs \\ %{}) do
    Pane.changeset(pane, attrs)
  end
end
