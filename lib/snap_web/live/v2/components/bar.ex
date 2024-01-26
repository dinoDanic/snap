defmodule SnapWeb.V2.Components.Bar do
  use Phoenix.LiveComponent
  use LiveSvelte.Components

  attr :window, :list, required: true
  attr :session, :list, required: true

  def bar(assigns) do
    ~H"""
    <div class="flex gap-sm pl-md">
      <%= @session.name %>
      <p>-</p>
      <%= for pane <- @window.panes do %>
        <p><%= pane.name %></p>
      <% end %>
    </div>
    """
  end
end
