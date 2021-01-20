defmodule Nautilus do

    use Application

    def start(_type, _args) do

        children = [
            {Nautilus.Network.Listener, []}
        ]

        opts = [strategy: :one_for_one, name: Nautilus.Supervisor]
        Supervisor.start_link(children, opts)
    end

end
