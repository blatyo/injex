defmodule Injex.Mixfile do
  use Mix.Project

  def project do
    [app: :injex,
     version: "1.0.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     deps: deps()]
  end

  def description do
    "A simple way to describe dependencies that can be replaced at test time."
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    []
  end

  defp package do
    [# These are the default files included in the package
     name: :injex,
     files: ["lib", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
     maintainers: ["Allen Madsen"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/blatyo/injex",
              "Docs" => "http://hexdocs.pm/injex"}]
  end
end
