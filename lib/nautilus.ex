defmodule Nautilus do

    use Application

    @tcp_listener Application.get_env(:nautilus, :TCPListener)


    def start(_type, _args) do

        children = [
            {@tcp_listener, []}
        ]

        opts = [strategy: :one_for_one, name: Nautilus.Supervisor]
        Supervisor.start_link(children, opts)
    end

end
