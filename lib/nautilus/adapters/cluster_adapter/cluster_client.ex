defmodule Nautilus.Adapters.Cluster.ClusterClient do

    require Logger
    use GenServer


    # Para o futuro retirar o registro de dentro desse modulo


    @key_value_adapter Application.get_env(:nautilus, :KeyValueBucketInterface)


    def start_link(connection_info) do
        GenServer.start(__MODULE__, %{socket: nil, ip: connection_info[:ip], port: connection_info[:port]})
    end


    def init(state) do
        GenServer.cast(self(), :connect)
        GenServer.cast(self(), :register)

        {:ok, state}
    end


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


    def do_remote_register do
        message = "version: 1.0\r\nto: 127.0.0.1:10000\r\nfrom: client\r\naction: register-client\r\ntype: request\r\nbody-size: 0\r\n\r\n"
        GenServer.cast(self(), {:send_message, message})
        {:ok, :registered}
    end


    def handle_cast(:connect, state) do
        Logger.info "Connecting to remote gateway #{:inet.ntoa(state[:ip])}:#{state[:port]}"
        case :gen_tcp.connect(state[:ip], state[:port], [:binary, active: true]) do
            {:ok, socket} ->
                {:noreply, %{state | socket: socket}}
            {:error, reason} ->
                GenServer.cast(self(), {:disconnect, reason})
        end
    end


    def handle_cast({:disconnect, reason}, state) do
        Logger.info "Disconnected from remote gateway, reason: #{reason}"
        {:stop, :normal, state}
    end


    def handle_cast(:register, state) do
        do_local_register(state[:ip], state[:port])
        do_remote_register()
        {:noreply, state}
    end


    def handle_cast({:send_message, message}, %{socket: socket} = state) do
        Logger.info "Sending #{message}" # retirar
        :ok = :gen_tcp.send(socket, message)
        {:noreply, state}
    end


    def handle_info({:tcp, _, data}, state) do
        Logger.info "Recv:  #{data}"
        # mandar para o nucleo nas actions quando receber a resposta se ocorrer um erro limpar os registros locais senão ignorar
        {:noreply, state}
    end


    def handle_info({:tcp_error, _}, state), do: {:stop, :normal, state}
    def handle_info({:tcp_closed, _}, state), do: {:stop, :normal, state}

end
