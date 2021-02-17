defmodule Nautilus do

    use Application

    @tcp_listener Application.get_env(:nautilus, :TCPListener)
    @key_value_bucket Application.get_env(:nautilus, :KeyValueBucket)


    def start(_type, _args) do

        children = [
            {@key_value_bucket, []},
            {@tcp_listener, []}
        ]

        opts = [strategy: :one_for_one, name: Nautilus.Supervisor]
        Supervisor.start_link(children, opts)
    end

end
