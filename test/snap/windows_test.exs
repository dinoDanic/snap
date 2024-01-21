defmodule Snap.WindowsTest do
  use Snap.DataCase

  alias Snap.Windows

  describe "windows" do
    alias Snap.Windows.Window

    import Snap.WindowsFixtures

    @invalid_attrs %{name: nil}

    test "list_windows/0 returns all windows" do
      window = window_fixture()
      assert Windows.list_windows() == [window]
    end

    test "get_window!/1 returns the window with given id" do
      window = window_fixture()
      assert Windows.get_window!(window.id) == window
    end

    test "create_window/1 with valid data creates a window" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Window{} = window} = Windows.create_window(valid_attrs)
      assert window.name == "some name"
    end

    test "create_window/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Windows.create_window(@invalid_attrs)
    end

    test "update_window/2 with valid data updates the window" do
      window = window_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Window{} = window} = Windows.update_window(window, update_attrs)
      assert window.name == "some updated name"
    end

    test "update_window/2 with invalid data returns error changeset" do
      window = window_fixture()
      assert {:error, %Ecto.Changeset{}} = Windows.update_window(window, @invalid_attrs)
      assert window == Windows.get_window!(window.id)
    end

    test "delete_window/1 deletes the window" do
      window = window_fixture()
      assert {:ok, %Window{}} = Windows.delete_window(window)
      assert_raise Ecto.NoResultsError, fn -> Windows.get_window!(window.id) end
    end

    test "change_window/1 returns a window changeset" do
      window = window_fixture()
      assert %Ecto.Changeset{} = Windows.change_window(window)
    end
  end
end
