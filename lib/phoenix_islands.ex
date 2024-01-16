defmodule PhoenixIslands do
  @moduledoc """
  Documentation for `PhoenixIslands`.
  """

  use Phoenix.Component
  alias PhoenixIslands.LiveData

  # defp attribute(:component), do: "phx-island-component"
  # defp attribute(:store_key), do: "phx-island-global-store-key"

  defp class(:root), do: "phx-island_root"
  defp class(:data), do: "phx-island_data"
  defp class(:content), do: "phx-island_content"
  defp class(:children), do: "phx-island_children"
  # defp class(:mounted_children), do: "phx-island_children-mounted"

  @island_types [
    :data,
    :lit,
    :react,
    :solid,
    :svelte,
    :vue
  ]

  attr :id, :string
  attr :type, :atom, default: :data, values: @island_types
  attr :component, :string, examples: ["Clock"], default: nil
  attr :data, :map, examples: [%{"foo" => "bar"}], default: nil
  attr :global_store_key, :string, default: nil
  attr :live, :boolean, default: false

  slot :inner_block

  #  <%!-- @attribute_component={@component}
  #  @attribute_global_store_key={@global_store_key} --%>
  def island(assigns) do
    ~H"""
    <div class={class(:root)} id={@id}
      style={if(!@component || @type == :data, do: "display: none", else: "")}
      phx-hook={phx_hook(@type)}
      phx-island-component={@component}
      phx-island-global-store-key={@global_store_key}
    >
      <%= if @type != :data do %>
        <div id={@id <> "-content"} class={class(:content)} phx-update="ignore" />
      <% end %>
      <div class={class(:data)} style="display: none">
        <%= if @live do %>
          <.live_component module={LiveData} data={@data} id={@id <> "-data"} />
          <% else %>
          <.data data={@data} path={@id <> "-data"} />
        <% end %>
      </div>
      <%= if @inner_block do %>
        <div class={class(:children)} style="display: none">
          <%= render_slot(@inner_block) %>
        </div>
      <% end %>
    </div>
    """
  end

  defp phx_hook(type) when type in @island_types,
    do: (type |> Atom.to_string() |> String.capitalize()) <> "Island"

  defp phx_hook(_), do: nil

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
