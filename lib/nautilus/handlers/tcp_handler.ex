defmodule Nautilus.Handlers.TCPHandler do

    use GenServer
    require Logger

    @behaviour :ranch_protocol

    def start_link(ref, socket, transport) do
        Logger.info("Starting server")
        pid = :proc_lib.spawn_link(__MODULE__, :init, [ref, socket, transport])
        {:ok, pid}
    end

    def send_message(message) do
        GenServer.cast(self(), {:send_message, message})
    end

    def init(ref, transport, _opts) do
        Logger.info("Starting protocol")
        {:ok, socket} = :ranch.handshake(ref)
        :ok = transport.setopts(socket, [{:active, true}])
        :gen_server.enter_loop(__MODULE__, [], %{socket: socket, transport: transport})
    end

    def handle_info({:tcp, socket, data}, state = %{socket: socket, transport: transport}) do
        Logger.info(data)
        send_message(data)
        {:noreply, state}
    end

    def handle_info({:tcp_closed, socket}, state = %{socket: socket, transport: transport}) do
        Logger.info("Closing")
        transport.close(socket)
        {:stop, :normal, state}
    end

    def handle_cast({:send_message, message}, state = %{socket: socket, transport: transport}) do
        transport.send(socket, message)
        {:noreply, state}
    end

end
