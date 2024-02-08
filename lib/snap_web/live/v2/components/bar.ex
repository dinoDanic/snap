defmodule SnapWeb.V2.Components.Bar do
  use Phoenix.LiveComponent
  use LiveSvelte.Components

  attr :window, :list, required: true
  attr :session, :list, required: true

  def bar(assigns) do
    ~H"""
    <div class="flex gap-sm pl-md">
      <%= @session.name %>
      <p>-></p>
      <%= for window <- @session.windows do %>
        <.link patch={"/v2/s/17/w/#{window.id}"}>
          <p class="hover:underline"><%= window.name %></p>
        </.link>
      <% end %>
    </div>
    """
  end
end
