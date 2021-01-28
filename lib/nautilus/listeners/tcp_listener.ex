defmodule Nautilus.Listeners.TCPListener do

    use GenServer
    require Logger
    alias Nautilus.Handlers.TCPHandler

    def start_link(opts) do
        GenServer.start_link(__MODULE__, :ok, opts)
    end

    def init(:ok) do
        listen_port = Application.fetch_env!(:nautilus, :listen_port)
        opts = [port: listen_port]

        Logger.info("listener waiting for a connection on port: #{listen_port}")

        {:ok, _} = :ranch.start_listener(:nautilus, :ranch_tcp, opts, TCPHandler, [])
        {:ok, []}
    end

end
