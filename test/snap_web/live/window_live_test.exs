defmodule SnapWeb.WindowLiveTest do
  use SnapWeb.ConnCase

  import Phoenix.LiveViewTest
  import Snap.WindowsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_window(_) do
    window = window_fixture()
    %{window: window}
  end

  describe "Index" do
    setup [:create_window]

    test "lists all windows", %{conn: conn, window: window} do
      {:ok, _index_live, html} = live(conn, ~p"/windows")

      assert html =~ "Listing Windows"
      assert html =~ window.name
    end

    test "saves new window", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/windows")

      assert index_live |> element("a", "New Window") |> render_click() =~
               "New Window"

      assert_patch(index_live, ~p"/windows/new")

      assert index_live
             |> form("#window-form", window: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#window-form", window: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/windows")

      html = render(index_live)
      assert html =~ "Window created successfully"
      assert html =~ "some name"
    end

    test "updates window in listing", %{conn: conn, window: window} do
      {:ok, index_live, _html} = live(conn, ~p"/windows")

      assert index_live |> element("#windows-#{window.id} a", "Edit") |> render_click() =~
               "Edit Window"

      assert_patch(index_live, ~p"/windows/#{window}/edit")

      assert index_live
             |> form("#window-form", window: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#window-form", window: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/windows")

      html = render(index_live)
      assert html =~ "Window updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes window in listing", %{conn: conn, window: window} do
      {:ok, index_live, _html} = live(conn, ~p"/windows")

      assert index_live |> element("#windows-#{window.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#windows-#{window.id}")
    end
  end

  describe "Show" do
    setup [:create_window]

    test "displays window", %{conn: conn, window: window} do
      {:ok, _show_live, html} = live(conn, ~p"/windows/#{window}")

      assert html =~ "Show Window"
      assert html =~ window.name
    end

    test "updates window within modal", %{conn: conn, window: window} do
      {:ok, show_live, _html} = live(conn, ~p"/windows/#{window}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Window"

      assert_patch(show_live, ~p"/windows/#{window}/show/edit")

      assert show_live
             |> form("#window-form", window: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#window-form", window: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/windows/#{window}")

      html = render(show_live)
      assert html =~ "Window updated successfully"
      assert html =~ "some updated name"
    end
  end
end
