defmodule Snap.Sessions do
  @moduledoc """
  The Sessions context.
  """
  alias Snap.SessionsUsers.SessionUser

  import Ecto.Query, warn: false
  alias Snap.Sessions
  alias Snap.Users
  alias Snap.Repo

  alias Snap.Sessions.Session

  def invite_user_to_session(email, session_id) do
    user = Users.get_user_by_email(email)

    case user do
      nil ->
        IO.puts("TU SAAAAAAAAAAAAAAm 3")
        {:error, "User not found"}

      {:ok, user} ->
        IO.puts("TU SAAAAAAAAAAAAAAm 4")
        session = Sessions.get_session(session_id)

        attrs = %{user_id: user.id, session_id: session.id}

        %SessionUser{}
        |> SessionUser.changeset(attrs)
        |> Repo.insert()
    end
  end

  def get_user_sessions(user_id) do
    user = Users.get_user!(user_id) |> Repo.preload(:sessions)
    user.sessions
  end

  @doc """
  Returns the list of sessions.

  ## Examples

      iex> list_sessions()
      [%Session{}, ...]

  """
  def list_sessions do
    Repo.all(Session)
  end

  @doc """
  Gets a single session.

  Raises `Ecto.NoResultsError` if the Session does not exist.

  ## Examples

      iex> get_session!(123)
      %Session{}

      iex> get_session!(456)
      ** (Ecto.NoResultsError)

  """
  def get_session(id), do: Repo.get(Session, id)

  @doc """
  Creates a session.

  ## Examples

      iex> create_session(%{field: value})
      {:ok, %Session{}}

      iex> create_session(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def create_session(attrs, user_id) do
    user = Users.get_user!(user_id)

    %Session{}
    |> Session.create_changeset(attrs)
    |> Ecto.Changeset.put_assoc(:admin, user)
    |> Ecto.Changeset.put_assoc(:users, [user])
    |> Repo.insert()

    # |> broadcast(:session_created)
  end

  @doc """
  Updates a session.

  ## Examples

      iex> update_session(session, %{field: new_value})
      {:ok, %Session{}}

      iex> update_session(session, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_session(%Session{} = session, attrs) do
    session
    |> Session.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a session.

  ## Examples

      iex> delete_session(session)
      {:ok, %Session{}}

      iex> delete_session(session)
      {:error, %Ecto.Changeset{}}

  """
  def delete_session(session_id) do
    session = get_session(session_id)
    Repo.delete(session)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking session changes.

  ## Examples

      iex> change_session(session)
      %Ecto.Changeset{data: %Session{}}

  """
  def change_session(%Session{} = session, attrs \\ %{}) do
    Session.changeset(session, attrs)
  end
end
