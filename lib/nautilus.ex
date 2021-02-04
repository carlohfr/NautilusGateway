defmodule Nautilus do

    use Application

    def start(_type, _args) do

        children = [
            {Nautilus.TCPMessageListener.TCPListener, []}
        ]

        opts = [strategy: :one_for_one, name: Nautilus.Supervisor]
        Supervisor.start_link(children, opts)
    end

end
