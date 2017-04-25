defmodule PCAPredict.Mixfile do
  use Mix.Project

  def project do
    [app: :pca_predict,
     version: "0.1.0",
     elixir: "~> 1.3",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps(),
     name: "PCA Predict",
     source_url: "https://github.com/sauce-consultants/pca_predict",
   ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  defp description do
    """
    A PCA Predict API wrapper for Elixir.
    """
  end


  defp package do
    # These are the default files included in the package
    [
      name: :pca_predict,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["John Polling", "Matt Weldon"],
      licenses: ["CC0-1.0"],
      links: %{"GitHub" => "https://github.com/sauce-consultants/pca_predict"}
    ]
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
    [
      {:httpoison, "~> 0.11.1"},
      {:poison, "~> 3.1"},
      {:exconstructor, "~> 1.1"},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:bypass, "~> 0.6.0", only: :test}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]
end
