defmodule Nautilus.MixProject do

    use Mix.Project

    def project do
        [
            app: :nautilus,
            version: "0.1.0",
            elixir: "~> 1.10",
            start_permanent: Mix.env() == :prod,
            deps: deps(),

            #Docs
            name: "Nautilus Gateway",
            docs: [
                main: "readme",
                api_reference: false,
                formatters: ["html"],
                extras: ["README.md", "LICENSE"],
                nest_modules_by_prefix: [Nautilus.Core, Nautilus.Adapters, Nautilus.Ports]
            ]
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
            {:uuid, "~> 1.1"},
            {:ranch, "~> 2.0"},
            {:ex_doc, "~> 0.23.0", only: :dev, runtime: false},
        ]
    end

end
