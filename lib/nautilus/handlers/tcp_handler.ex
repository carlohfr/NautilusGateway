defmodule Nautilus.Handlers.TCPHandler do

    use GenServer
    require Logger
    alias Nautilus.Handlers.MessageHandler

    @behaviour :ranch_protocol

    def start_link(ref, socket, transport) do
        Logger.info("New client") #just for test, remove in final version
        pid = :proc_lib.spawn_link(__MODULE__, :init, [ref, socket, transport])
        {:ok, pid}
    end

    def init(ref, transport, _opts) do
        Logger.info("Starting TCP handler") #just for test, remove in final version
        {:ok, socket} = :ranch.handshake(ref)
        :ok = transport.setopts(socket, [{:active, true}])
        :gen_server.enter_loop(__MODULE__, [], %{socket: socket, transport: transport})
    end

    def handle_info({:tcp, socket, message}, state = %{socket: socket, transport: _transport}) do
        Logger.info("Recv: " <> message) #just for test, remove in final version
        _pid = spawn(MessageHandler, :process_message, [self(), message])
        {:noreply, state}
    end

    def handle_info({:tcp_closed, socket}, state = %{socket: socket, transport: transport}) do
        Logger.info("Closing") #just for test, remove in final version
        transport.close(socket)
        {:stop, :normal, state}
    end

    def handle_cast({:send_message, message}, state = %{socket: socket, transport: transport}) do
        transport.send(socket, message)
        {:noreply, state}
    end

end
