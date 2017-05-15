defmodule Urlpreview.Mixfile do
  use Mix.Project

  def project do
    [app: :urlpreview,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger, :httpotion, :floki, :fuzzyurl]]
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
    [{:httpotion, "~> 3.0.2"}, # https://github.com/myfreeweb/httpotion
     {:floki, "~> 0.17.0"}, # https://github.com/philss/floki
     {:fuzzyurl, "~> 0.9.0"}] # https://github.com/gamache/fuzzyurl.ex
  end
end
