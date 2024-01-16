defmodule PhoenixIslands.LiveData do
  use Phoenix.LiveComponent

  attr :data, :any

  def render(%{data: x} = assigns) when is_nil(x),
    do: ~H"""
    <span class="null"/>
    """

  def render(%{data: x} = assigns) when is_boolean(x),
    do: ~H"""
    <span class="boolean"><%= @data %></span>
    """

  def render(%{data: x} = assigns) when is_number(x),
    do: ~H"""
    <span class="number"><%= @data %></span>
    """

  def render(%{data: x} = assigns) when is_binary(x) or is_atom(x),
    do: ~H"""
    <span><%= @data %></span>
    """

  def render(%{data: {_streams, stream}} = assigns) when is_atom(stream),
    do: ~H"""
    <ul phx-update="stream" id={@id <> "-stream"}>
      <li :for={{dom_id, item} <- elem(@data, 0)[elem(@data, 1)]} id={dom_id}>
        <.live_component module={__MODULE__} data={item} id={"#{@id}[#{dom_id}]"} />
      </li>
    </ul>
    """

  def render(%{data: x} = assigns) when is_list(x),
    do: ~H"""
    <ul>
      <%= for {item, idx} <- @data |> Enum.with_index() do %>
        <%= if is_map(item) && Map.get(item, "id") do %>
          <li id={Map.get(item, "id")}><.live_component module={__MODULE__} data={item} id={@id <> "[#{idx}]"} /></li>
        <% else %>
          <li><.live_component module={__MODULE__} data={item} id={"#{@id}[#{idx}]"} /></li>
        <% end %>
      <% end %>
    </ul>
    """

  def render(%{data: x} = assigns) when is_map(x),
    do: ~H"""
    <dl>
      <%= for {k, v} <- Map.to_list(@data) do %>
        <dt><%= k %></dt>
        <dd><.live_component module={__MODULE__} data={v} id={"#{@id}[#{k}]"} /></dd>
      <% end %>
    </dl>
    """
end
