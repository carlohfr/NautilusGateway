defmodule Nautilus.Adapters.Network.TCP.TCPListener do

    @moduledoc """
    This function is responsible for start the tcp listener
    """

    use GenServer
    require Logger

    @tcp_handler Application.get_env(:nautilus, :TCPHandler)
    @listen_port Application.get_env(:nautilus, :listen_port)


    @doc """
    This function will receive the options and start the module
    """
    def start_link(opts) do
        GenServer.start_link(__MODULE__, :ok, opts)
    end


    @doc """
    This function is a callback for start_link(), and will starts the tcp listener
    """
    def init(:ok) do
        Logger.info("listener waiting for a connection on port: #{@listen_port}")

        opts = [port: @listen_port]
        {:ok, _} = :ranch.start_listener(:nautilus, :ranch_tcp, opts, @tcp_handler, [])
        {:ok, []}
    end

end
