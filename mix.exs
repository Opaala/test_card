defmodule TestCard.Mixfile do
  use Mix.Project

  def project do
    [app: :test_card,
     version: "0.1.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {TestCard, []},
     applications: [:phoenix, :phoenix_pubsub, :cowboy, :logger, :gettext, :gproc,
                    :exconstructor]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2.0"},
     {:phoenix_pubsub, "~> 1.0"},
     {:gettext, "~> 0.11"},
     {:cowboy, "~> 1.0"},
     {:gproc, "~> 0.5.0"},
     {:exconstructor, "~> 1.0.2"},
     {:exrm, "~> 1.0.6"}]
  end
end
