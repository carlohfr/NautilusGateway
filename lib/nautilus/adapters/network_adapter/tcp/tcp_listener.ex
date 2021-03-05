defmodule Nautilus.Network.TCP.TCPListener do

    use GenServer
    require Logger

    @tcp_handler Application.get_env(:nautilus, :TCPHandler)
    @listen_port Application.get_env(:nautilus, :listen_port)


    def start_link(opts) do
        GenServer.start_link(__MODULE__, :ok, opts)
    end


    def init(:ok) do
        Logger.info("listener waiting for a connection on port: #{@listen_port}")

        opts = [port: @listen_port]
        {:ok, _} = :ranch.start_listener(:nautilus, :ranch_tcp, opts, @tcp_handler, [])
        {:ok, []}
    end

end
