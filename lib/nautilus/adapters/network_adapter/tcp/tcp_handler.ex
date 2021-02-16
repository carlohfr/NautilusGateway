defmodule Nautilus.Network.TCP.TCPHandler do

    use GenServer
    require Logger

    @behaviour :ranch_protocol
    @network_message_handler Application.get_env(:nautilus, :NetworkMessageHandler)


    def start_link(ref, socket, transport) do
        Logger.info("New client") #just for test, remove in final version
        pid = :proc_lib.spawn_link(__MODULE__, :init, [ref, socket, transport])
        {:ok, pid}
    end


    def init(args) do
        {:ok, args}
    end


    def init(ref, transport, _opts) do
        {:ok, socket} = :ranch.handshake(ref)
        :ok = transport.setopts(socket, [{:active, true}])
        :gen_server.enter_loop(__MODULE__, [], %{socket: socket, transport: transport})
    end


    def handle_info({:tcp, socket, message}, state = %{socket: socket, transport: _transport}) do
        IO.puts(message) #just for test, remove in final version
        _pid = spawn(@network_message_handler, :handle_message, [message])
        {:noreply, state}
    end


    def handle_info({:tcp_closed, socket}, state = %{socket: socket, transport: transport}) do
        Logger.info("Client quit") #just for test, remove in final version
        transport.close(socket)
        {:stop, :normal, state}
    end


    def handle_cast({:send_message, message}, state = %{socket: socket, transport: transport}) do
        transport.send(socket, message)
        {:noreply, state}
    end

end