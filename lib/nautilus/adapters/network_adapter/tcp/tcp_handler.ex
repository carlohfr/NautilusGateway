defmodule Nautilus.Adapters.Network.TCP.TCPHandler do

    @doc """
    This module is responsible for handle the tcp connection with a client
    """

    use GenServer
    require Logger

    @behaviour :ranch_protocol
    @message_preparator Application.get_env(:nautilus, :MessagePreparator)


    @doc """
    This function is the main function for this module, and will starts the handler
    """
    def start_link(ref, socket, transport) do
        Logger.info("New client") #just for test, remove in final version
        pid = :proc_lib.spawn_link(__MODULE__, :init, [ref, socket, transport])
        {:ok, pid}
    end


    @doc """
    This function is a callback for start_link()
    """
    def init(args) do
        {:ok, args}
    end


    @doc """
    This function is a callback for start_link(), and will start the loop
    """
    def init(ref, transport, _opts) do
        {:ok, socket} = :ranch.handshake(ref)
        :ok = transport.setopts(socket, [{:active, true}])
        :gen_server.enter_loop(__MODULE__, [], %{socket: socket, transport: transport})
    end


    @doc """
    This function will receive the incoming message
    """
    def handle_info({:tcp, socket, message}, state = %{socket: socket, transport: _transport}) do
        IO.puts(message) #just for test, remove in final version
        _pid = spawn(@message_preparator, :prepare_message, [self(), message])
        {:noreply, state}
    end


    @doc """
    This function handles with close connection event
    """
    def handle_info({:tcp_closed, socket}, state = %{socket: socket, transport: transport}) do
        Logger.info("Client quit") #just for test, remove in final version
        transport.close(socket)
        {:stop, :normal, state}
    end


    @doc """
    This function will send the outcoming message
    """
    def handle_cast({:send_message, message}, state = %{socket: socket, transport: transport}) do
        transport.send(socket, message)
        {:noreply, state}
    end

end
