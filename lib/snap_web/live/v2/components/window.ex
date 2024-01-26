defmodule SnapWeb.V2.Components.Window do
  alias Snap.Windows.Window
  use Phoenix.LiveComponent

  attr :window, Window

  def render(assigns) do
    ~H"""
    <%= @window.name %>
    """
  end
end
