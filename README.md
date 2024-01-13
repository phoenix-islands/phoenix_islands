# Phoenix Islands

Library for creating islands of various frontend frameworks in Phoenix LiveView

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `phoenix_islands` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:phoenix_islands, "~> 0.0.3"}
  ]
end
```

## Usage

```elixir
defmodule ExampleWeb.IslandsLive do
  use ExampleWeb, :live_view

  # add this
  import PhoenixIslands

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :counter, 1)}
  end

  def handle_event("update_counter", %{"counter" => counter}, socket) do
    {:noreply,
     assign(
       socket,
       :counter,
       if(is_binary(counter), do: String.to_integer(counter), else: counter)
     )}
  end
end
```

Then you can pick an frontend framework and start the integration

## React

Integrate react by following [this instruction](`e:phoenix_islands:react.md`) and start rendering:

```heex
<div class="px-4 py-10 sm:px-6 sm:py-28 lg:px-8 xl:px-28 xl:py-32">
  <div class="mx-auto max-w-xl lg:mx-0">
    <p class="text-[1.2rem] mt-4 font-semibold leading-10 tracking-tighter text-zinc-900">
      Live View React Island
    </p>
    <.island id="1" type={:react} component="ReactCounter" data={%{"counter" => @counter}}>
      <div class="w-full flex flex-row gap-3 items-center justify-between">
        <span>Server State: <%= @counter %></span>
        <button
          class="phx-submit-loading:opacity-75 rounded-lg bg-zinc-900 hover:bg-zinc-700 py-2 px-3 text-sm font-semibold leading-6 text-white active:text-white/80"
          phx-click="update_counter"
          phx-value-counter={@counter - 1}
        >
          LiveView -1
        </button>
      </div>
    </.island>
  </div>
</div>
```
