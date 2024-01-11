defmodule PhoenixIslands.MixProject do
  use Mix.Project

  def project do
    [
      app: :phoenix_islands,
      version: "0.0.1",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description() do
    "Library for creating islands of various frontend framework in Phoenix LiveView"
  end

  defp package() do
    [
      name: "phoenix_islands",
      # These are the default files included in the package
      # files: ~w(lib priv .formatter.exs mix.exs README* readme* LICENSE*
      #           license* CHANGELOG* changelog* src),
      files: ~w(lib .formatter.exs mix.exs README*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/phoenix-islands/phoenix_islands"}
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:phoenix_live_view, ">= 0.20.1"}
    ]
  end
end
