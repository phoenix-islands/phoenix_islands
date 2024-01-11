defmodule PhoenixIslands do
  @moduledoc """
  Documentation for `PhoenixIslands`.
  """

  use Phoenix.Component

  attr :id, :string
  attr :component, :string
  attr :data, :any
  slot :inner_block

  def island(assigns) do
    ~H"""
    <div class="phx-island" id={@id} phx-hook="ReactIsland" x-component={@component}>
      <div id={@id <> "-content"} class="phx-island_content" phx-update="ignore" />
      <div class="phx-island_data" style="display: none">
        <.data data={@data} path={@id <> "-data"} />
      </div>
      <%= if @inner_block do %>
        <div class="phx-island_children" style="display: none">
          <%= render_slot(@inner_block) %>
        </div>
      <% end %>
    </div>
    """
  end

  defp data(%{data: x} = assigns) when is_nil(x),
    do: ~H"""
    <span class="null" path={@path} />
    """

  defp data(%{data: x} = assigns) when is_boolean(x),
    do: ~H"""
    <span class="boolean" path={@path}><%= @data %></span>
    """

  defp data(%{data: x} = assigns) when is_number(x),
    do: ~H"""
    <span class="number" path={@path}><%= @data %></span>
    """

  defp data(%{data: x} = assigns) when is_binary(x) or is_atom(x),
    do: ~H"""
    <span path={@path}><%= @data %></span>
    """

  defp data(%{data: {_streams, stream}} = assigns) when is_atom(stream),
    do: ~H"""
    <ul phx-update="stream" id={@path}>
      <li :for={{dom_id, item} <- elem(@data, 0)[elem(@data, 1)]} id={dom_id}>
        <.data data={item} path={"#{@path}[#{dom_id}]"} />
      </li>
    </ul>
    """

  defp data(%{data: x} = assigns) when is_list(x),
    do: ~H"""
    <ul>
      <%= for {item, idx} <- @data |> Enum.with_index() do %>
        <%= if is_map(item) do %>
          <li id={Map.get(item, "id")}><.data data={item} path={"#{@path}[#{idx}]"} /></li>
        <% else %>
          <li><.data data={item} path={"#{@path}[#{idx}]"} /></li>
        <% end %>
      <% end %>
    </ul>
    """

  defp data(%{data: x} = assigns) when is_map(x),
    do: ~H"""
    <dl>
      <%= for {k, v} <- Map.to_list(@data) do %>
        <dt><%= k %></dt>
        <dd><.data data={v} path={"#{@path}[#{k}]"} /></dd>
      <% end %>
    </dl>
    """
end
