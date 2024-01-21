defmodule Snap.PanesTest do
  use Snap.DataCase

  alias Snap.Panes

  describe "panes" do
    alias Snap.Panes.Pane

    import Snap.PanesFixtures

    @invalid_attrs %{name: nil}

    test "list_panes/0 returns all panes" do
      pane = pane_fixture()
      assert Panes.list_panes() == [pane]
    end

    test "get_pane!/1 returns the pane with given id" do
      pane = pane_fixture()
      assert Panes.get_pane!(pane.id) == pane
    end

    test "create_pane/1 with valid data creates a pane" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Pane{} = pane} = Panes.create_pane(valid_attrs)
      assert pane.name == "some name"
    end

    test "create_pane/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Panes.create_pane(@invalid_attrs)
    end

    test "update_pane/2 with valid data updates the pane" do
      pane = pane_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Pane{} = pane} = Panes.update_pane(pane, update_attrs)
      assert pane.name == "some updated name"
    end

    test "update_pane/2 with invalid data returns error changeset" do
      pane = pane_fixture()
      assert {:error, %Ecto.Changeset{}} = Panes.update_pane(pane, @invalid_attrs)
      assert pane == Panes.get_pane!(pane.id)
    end

    test "delete_pane/1 deletes the pane" do
      pane = pane_fixture()
      assert {:ok, %Pane{}} = Panes.delete_pane(pane)
      assert_raise Ecto.NoResultsError, fn -> Panes.get_pane!(pane.id) end
    end

    test "change_pane/1 returns a pane changeset" do
      pane = pane_fixture()
      assert %Ecto.Changeset{} = Panes.change_pane(pane)
    end
  end
end
