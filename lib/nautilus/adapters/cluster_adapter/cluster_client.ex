defmodule Nautilus.Adapters.Cluster.ClusterClient do

    @moduledoc """
    This module is responsible for communication with another gateway
    """

    require Logger
    use GenServer

    # Para o futuro retirar o registro de dentro desse modulo

    @get_hostname Application.get_env(:nautilus, :GetHostname)
    @message_preparator Application.get_env(:nautilus, :MessagePreparator)
    @key_value_adapter Application.get_env(:nautilus, :KeyValueBucketInterface)


    @doc """
    This is the main function for the module, and is responsible for calling init() function passing ip and port of remote gateway
    """
    def start_link(connection_info) do
        GenServer.start(__MODULE__, %{socket: nil, ip: connection_info[:ip], port: connection_info[:port]})
    end


    @doc """
    This function will starts the connection and do registration in both sides (locally and remotely)
    """
    def init(state) do
        #GenServer.cast(self(), :connect)
        GenServer.cast(self(), :register)
        {:ok, state}
    end


    @doc """
    This function will perform a local register saving ip, port and pid for this module
    """
    def do_local_register(ip, port) do
        gateway_info =  %{:pid => self(), :ip => ip, :port => port, :type => :gateway}
        id = "#{:inet.ntoa(ip)}:#{port}"
        case @key_value_adapter.set({id, gateway_info}) do
            :ok ->
                {:ok, :registered}
            _ ->
                GenServer.cast(self(), {:disconnect, :kill})
        end
    end


    @doc """
    This function will perform a remote register
    """
    def do_remote_register(ip, port) do
        to = "#{:inet.ntoa(ip)}:#{port}"
        {_, from} = @get_hostname.get_hostname()
        network_name = "rede1"
        network_password = "1q2w3e4r"
        gateway_password = "1q2w3e4r"
        content = "network-name: #{network_name}\r\nnetwork-password: #{network_password}\r\ngateway-password: #{gateway_password}"
        message = "version: 1.0\r\nto: #{to}\r\nfrom: #{from}\r\naction: register-gateway\r\ntype: request\r\nbody-size: #{byte_size(content)}\r\n\r\n#{content}"
        IO.inspect(message)
        #GenServer.cast(self(), {:send_message, message})
        {:ok, :registered}
    end


    @doc """
    This is a callback function for connecting to remote gateway
    """
    def handle_cast(:connect, state) do
        Logger.info "Connecting to remote gateway #{:inet.ntoa(state[:ip])}:#{state[:port]}"
        case :gen_tcp.connect(state[:ip], state[:port], [:binary, active: true]) do
            {:ok, socket} ->
                {:noreply, %{state | socket: socket}}
            {:error, reason} ->
                GenServer.cast(self(), {:disconnect, reason})
        end
    end


    @doc """
    This is a callback function for disconnecting from remote gateway
    """
    def handle_cast({:disconnect, reason}, state) do
        Logger.info "Disconnected from remote gateway, reason: #{reason}"
        {:stop, :normal, state}
    end


    @doc """
    This is a callback function for local and remote register
    """
    def handle_cast(:register, state) do
        do_local_register(state[:ip], state[:port])
        do_remote_register(state[:ip], state[:port])
        {:noreply, state}
    end


    @doc """
    This is a callback function for send messages for remote gateway
    """
    def handle_cast({:send_message, message}, %{socket: socket} = state) do
        Logger.info "Sending #{message}" # retirar
        :ok = :gen_tcp.send(socket, message)
        {:noreply, state}
    end


    @doc """
    This is a callback function for receive messages from remote gateway
    """
    def handle_info({:tcp, _, message}, state) do
        Logger.info "Recv:  #{message}" # retirar
        _pid = spawn(@message_preparator, :prepare_message, [self(), message])
        {:noreply, state}
    end


    @doc """
    This is a callback functions for tcp error and tcp close events
    """
    def handle_info({:tcp_error, _}, state), do: {:stop, :normal, state}
    def handle_info({:tcp_closed, _}, state), do: {:stop, :normal, state}

end
