defmodule PhoenixIslands.MixProject do
  use Mix.Project

  def project do
    [
      app: :phoenix_islands,
      version: "0.0.0",
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
      # This option is only needed when you don't want to use the OTP application name
      name: "phoenix_islands",
      # These are the default files included in the package
      # files: ~w(lib priv .formatter.exs mix.exs README* readme* LICENSE*
      #           license* CHANGELOG* changelog* src),
      files: ~w(lib .formatter.exs mix.exs README*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/phoenix-islands/phoenix_islands"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
