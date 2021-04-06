defmodule Injex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :injex,
      version: "1.1.2",
      elixir: "~> 1.3",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: "A simple way to describe dependencies that can be replaced at test time.",
      package: package(),
      deps: deps(),
      aliases: [publish: ["hex.publish", &git_tag/1]]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: []]
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
    [{:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp package do
    [
      name: :injex,
      files: ["lib", "mix.exs", "README*", "LICENSE*", ".formatter.exs"],
      maintainers: ["Allen Madsen"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/blatyo/injex", "Docs" => "http://hexdocs.pm/injex"}
    ]
  end

  defp git_tag(_args) do
    tag = "v" <> Mix.Project.config()[:version]
    System.cmd("git", ["tag", tag])
    System.cmd("git", ["push", "origin", tag])
  end
end
