defmodule SnapWeb.PaneLiveTest do
  use SnapWeb.ConnCase

  import Phoenix.LiveViewTest
  import Snap.PanesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_pane(_) do
    pane = pane_fixture()
    %{pane: pane}
  end

  describe "Index" do
    setup [:create_pane]

    test "lists all panes", %{conn: conn, pane: pane} do
      {:ok, _index_live, html} = live(conn, ~p"/panes")

      assert html =~ "Listing Panes"
      assert html =~ pane.name
    end

    test "saves new pane", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/panes")

      assert index_live |> element("a", "New Pane") |> render_click() =~
               "New Pane"

      assert_patch(index_live, ~p"/panes/new")

      assert index_live
             |> form("#pane-form", pane: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#pane-form", pane: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/panes")

      html = render(index_live)
      assert html =~ "Pane created successfully"
      assert html =~ "some name"
    end

    test "updates pane in listing", %{conn: conn, pane: pane} do
      {:ok, index_live, _html} = live(conn, ~p"/panes")

      assert index_live |> element("#panes-#{pane.id} a", "Edit") |> render_click() =~
               "Edit Pane"

      assert_patch(index_live, ~p"/panes/#{pane}/edit")

      assert index_live
             |> form("#pane-form", pane: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#pane-form", pane: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/panes")

      html = render(index_live)
      assert html =~ "Pane updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes pane in listing", %{conn: conn, pane: pane} do
      {:ok, index_live, _html} = live(conn, ~p"/panes")

      assert index_live |> element("#panes-#{pane.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#panes-#{pane.id}")
    end
  end

  describe "Show" do
    setup [:create_pane]

    test "displays pane", %{conn: conn, pane: pane} do
      {:ok, _show_live, html} = live(conn, ~p"/panes/#{pane}")

      assert html =~ "Show Pane"
      assert html =~ pane.name
    end

    test "updates pane within modal", %{conn: conn, pane: pane} do
      {:ok, show_live, _html} = live(conn, ~p"/panes/#{pane}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Pane"

      assert_patch(show_live, ~p"/panes/#{pane}/show/edit")

      assert show_live
             |> form("#pane-form", pane: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#pane-form", pane: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/panes/#{pane}")

      html = render(show_live)
      assert html =~ "Pane updated successfully"
      assert html =~ "some updated name"
    end
  end
end
