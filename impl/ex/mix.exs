defmodule Predicator.Mixfile do
  use Mix.Project

  @name "Predicator"
  @app :predicator
  @description "A secure, non-evaling condition (boolean predicate) engine for end users"
  @version "0.9.3"

  @deps [
    # Required

    # Optional
    {:ecto, "~> 3.0", optional: true},

    # Development, Documentation, Testing, ...
    {:dialyxir, "~> 1.0.0-rc.4", only: :dev, runtime: false},
    {:ex_doc, "~> 0.23", only: :dev, runtime: false}
  ]

  def project() do
    [
      app: @app,
      name: @name,
      version: @version,
      elixir: "~> 1.6",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      aliases: aliases(),
      description: @description,
      deps: @deps,
      docs: docs()
    ]
  end

  def package() do
    [
      name: :predicator,
      maintainers: ["jrichocean", "johnnyt"],
      licenses: ["MIT"],
      docs: [extras: ["README.md"]],
      links: %{
        "Predicator Project" => "https://github.com/riddler/predicator",
        "GitHub" => "https://github.com/riddler/predicator/tree/master/impl/ex"
      }
    ]
  end

  defp aliases() do
    [compile: "compile --warnings-as-errors"]
  end

  def application() do
    [
      mod: {Predicator.Application, []},
      extra_applications: [
        :logger
      ]
    ]
  end

  defp docs() do
    [
      main: "readme",
      source_url: "https://github.com/riddler/predicator",
      source_ref: "ex-v#{@version}/impl/ex",
      extras: ["README.md"]
    ]
  end
end
