defmodule GroupSupervisor.Mixfile do
  use Mix.Project

  def project do
    [
      app: :group_supervisor,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls, test_task: "espec"],
      preferred_cli_env: [espec: :test, coveralls: :test,
                          "coveralls.detail": :test, "coveralls.post": :test,
                          "coveralls.html": :test],
      name: "Group Supervisor",
      source_url: "https://github.com/NightWolf007/du-group-supervisor",
      docs: [main: "Group Supervisor", extras: ["README.md"]]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: [:plug, :cowboy, :poison, :httpoison, :exredis],
      mod: {GroupSupervisor, []}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:maru, "~> 0.11"},
      {:maru_entity, "~> 0.2.0"},
      {:exredis, "~> 0.2"},
      {:httpoison, "~> 0.11.1"},
      {:poison, "~> 3.0"},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:credo, "~> 0.6", only: [:dev, :test]},
      {:espec, "~> 1.3", only: :test},
      {:excoveralls, "~> 0.6", only: :test}
    ]
  end
end
