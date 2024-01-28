defmodule Snap.Windows do
  @moduledoc """
  The Windows context.
  """
  alias Snap.Panes

  import Ecto.Query, warn: false
  alias Snap.Repo

  alias Snap.Windows.Window

  @doc """
  Returns the list of windows.

  ## Examples

      iex> list_windows()
      [%Window{}, ...]

  """
  def list_windows do
    Repo.all(Window)
  end

  @doc """
  Gets a single window.

  Raises `Ecto.NoResultsError` if the Window does not exist.

  ## Examples

      iex> get_window!(123)
      %Window{}

      iex> get_window!(456)
      ** (Ecto.NoResultsError)

  """
  def get_window!(id), do: Repo.get!(Window, id)

  @doc """
  Creates a window.

  ## Examples

      iex> create_window(%{field: value})
      {:ok, %Window{}}

      iex> create_window(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  # def create_window(attrs \\ %{}, session) do
  #   %Window{}
  #   |> Window.changeset(attrs)
  #   |> Ecto.Changeset.put_assoc(:session, session)
  #   |> Repo.insert()
  # end

  def create_window(attrs \\ %{}, session) do
    window_changeset =
      %Window{}
      |> Window.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:session, session)

    Repo.transaction(fn ->
      {:ok, window} = Repo.insert(window_changeset)
      welcome_pane_attrs = %{"name" => "Welcome Pane"}
      Panes.create_pane(welcome_pane_attrs, window)
      window
    end)
  end

  @doc """
  Updates a window.

  ## Examples

      iex> update_window(window, %{field: new_value})
      {:ok, %Window{}}

      iex> update_window(window, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_window(%Window{} = window, attrs) do
    window
    |> Window.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a window.

  ## Examples

      iex> delete_window(window)
      {:ok, %Window{}}

      iex> delete_window(window)
      {:error, %Ecto.Changeset{}}

  """
  def delete_window(%Window{} = window) do
    Repo.delete(window)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking window changes.

  ## Examples

      iex> change_window(window)
      %Ecto.Changeset{data: %Window{}}

  """
  def change_window(%Window{} = window, attrs \\ %{}) do
    Window.changeset(window, attrs)
  end
end
