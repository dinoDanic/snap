defmodule SnapWeb.ErrorHTMLTest do
  use SnapWeb.ConnCase, async: true

  # Bring render_to_string/4 for testing custom views
  import Phoenix.Template

  test "renders 404.html" do
    assert render_to_string(SnapWeb.ErrorHTML, "404", "html", []) == "Not Found"
  end

  test "renders 500.html" do
    assert render_to_string(SnapWeb.ErrorHTML, "500", "html", []) == "Internal Server Error"
  end
end
