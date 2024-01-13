defmodule PhoenixIslandsTest do
  use ExUnit.Case
  doctest PhoenixIslands

  test "should render" do
    assert PhoenixIslands.island(%{type: :react, id: "0"}) |> dbg != nil
    assert PhoenixIslands.react_island(%{type: :react, id: "0"}) |> dbg != nil
  end
end
