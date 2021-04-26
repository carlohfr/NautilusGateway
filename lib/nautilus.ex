defmodule Nautilus do

    @moduledoc """
    This module is the main module and starts others modules
    """

    use Application

    @tcp_listener Application.get_env(:nautilus, :TCPListener)
    @key_value_bucket Application.get_env(:nautilus, :KeyValueBucket)
    @cluster_manager Application.get_env(:nautilus, :ClusterManager)

    @doc """
    This function will start all main children processes
    """
    def start(_type, _args) do

        children = [
            {@key_value_bucket, []},
            {@tcp_listener, []},
            {@cluster_manager, []},
        ]

        opts = [strategy: :one_for_one, name: Nautilus.Supervisor]
        Supervisor.start_link(children, opts)
    end

end
