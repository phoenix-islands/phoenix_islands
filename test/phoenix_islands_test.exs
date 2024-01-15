defmodule PhoenixIslandsTest do
  use ExUnit.Case
  doctest PhoenixIslands

  test "should render" do
    assigns = %{type: :react, id: "0", data: %{"x" => 1}}
    rendered = PhoenixIslands.island(assigns)
    assert rendered != nil
    assert rendered.dynamic.(assigns) != nil
  end
end
