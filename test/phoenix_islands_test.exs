defmodule PhoenixIslandsTest do
  use ExUnit.Case
  doctest PhoenixIslands

  import Phoenix.LiveViewTest

  test "should render" do
    assigns = %{type: :react, id: "0", data: %{x: 1}}

    render_component(&PhoenixIslands.island/1, assigns) =~
      "<div class=\"phx-island_children\" style=\"display: none\">"
  end

  test "should render live data" do
    assigns = %{type: :react, id: "0", data: %{x: 1}, live: true}

    render_component(&PhoenixIslands.island/1, assigns) =~
      "<div class=\"phx-island_children\" style=\"display: none\">"
  end
end
