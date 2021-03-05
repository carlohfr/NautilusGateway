defmodule Nautilus.MixProject do

    use Mix.Project

    def project do
        [
            app: :nautilus,
            version: "0.1.0",
            elixir: "~> 1.10",
            start_permanent: Mix.env() == :prod,
            deps: deps()
        ]
    end

    def application do
        [
            extra_applications: [:logger],
            mod: {Nautilus, []}
        ]
    end

    defp deps do
        [
            {:ranch, "~> 2.0"},
            {:uuid, "~> 1.1"}
        ]
    end

end
