defmodule Urlpreview.Mixfile do
  use Mix.Project

  def project do
    [app: :urlpreview,
     version: "0.0.3",
     description: "Fetches meta data from websites and returns information useful for things such as URL previews.",
     package: package(),
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
     {:fuzzyurl, "~> 0.9.0"},  # https://github.com/gamache/fuzzyurl.ex
     {:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp package do
    %{
      name: :urlpreview,
      maintainers: ["Cameron Lockhart"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/cameeob2003/url-preview"
      },
      source_url: "https://github.com/cameeob2003/url-preview"
    }
  end
end
