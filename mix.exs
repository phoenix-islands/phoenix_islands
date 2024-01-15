defmodule PhoenixIslands.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :phoenix_islands,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      docs: &docs/0,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      source_url: "https://github.com/phoenix-islands/phoenix_islands",
      extra_section: "GUIDES",
      extras: extras(),
      groups_for_extras: groups_for_extras(),
      # groups_for_modules: groups_for_modules(),
      # groups_for_functions: [
      #   Components: &(&1[:type] == :component),
      #   Macros: &(&1[:type] == :macro)
      # ],
      skip_undefined_reference_warnings_on: ["CHANGELOG.md"],
      before_closing_body_tag: &before_closing_body_tag/1
    ]
  end

  defp before_closing_body_tag(:html) do
    """
    <script type="module">
    import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10.0.2/dist/mermaid.esm.min.mjs';
    mermaid.initialize({
      securityLevel: 'loose',
      theme: 'base'
    });
    </script>
    <style>
    code.mermaid text.flowchartTitleText {
      fill: var(--textBody) !important;
    }
    code.mermaid g.cluster > rect {
      fill: var(--background) !important;
      stroke: var(--neutralBackground) !important;
    }
    code.mermaid g.cluster[id$="__transparent"] > rect {
      fill-opacity: 0 !important;
      stroke: none !important;
    }
    code.mermaid g.nodes span.nodeLabel > em {
      font-style: normal;
      background-color: white;
      opacity: 0.5;
      padding: 1px 2px;
      border-radius: 5px;
    }
    code.mermaid g.edgePaths > path {
      stroke: var(--textBody) !important;
    }
    code.mermaid g.edgeLabels span.edgeLabel:not(:empty) {
      background-color: var(--textBody) !important;
      padding: 3px 5px !important;
      border-radius:25%;
      color: var(--background) !important;
    }
    code.mermaid .marker {
      fill: var(--textBody) !important;
      stroke: var(--textBody) !important;
    }
    </style>
    """
  end

  defp before_closing_body_tag(_), do: ""

  defp extras do
    ["README.md"] ++
      Path.wildcard("guides/*/*.md") ++
      ["CHANGELOG.md"]
  end

  defp groups_for_extras do
    [
      Introduction: ~r/guides\/introduction\/.?/,
      "Server-side features": ~r/guides\/server\/.?/,
      "Client-side integration": ~r/guides\/client\/.?/
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
      {:ex_doc, ">= 0.19.0", only: :dev, runtime: false},
      {:makeup_html, ">= 0.0.0", only: :dev, runtime: false},
      {:makeup_eex, ">= 0.0.0", only: :dev, runtime: false},
      {:phoenix_live_view, ">= 0.20.1"}
    ]
  end
end
