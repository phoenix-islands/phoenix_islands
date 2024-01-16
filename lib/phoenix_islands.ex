defmodule PhoenixIslands do
  @moduledoc """
  Documentation for `PhoenixIslands`.
  """

  use Phoenix.Component
  alias PhoenixIslands.Data

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
        <.live_component module={Data} data={@data} id={@id <> "-data"} />
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
end
