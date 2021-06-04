defmodule Nautilus.Adapters.Cluster.ClusterManager do

    @moduledoc """
    This module is responsible for managing all connections with remote gateways
    """

    use GenServer

    @cluster_client Application.get_env(:nautilus, :ClusterClient)

    def start_link(_) do
        GenServer.start(__MODULE__, %{socket: nil}, name: :ClusterManager)
    end


    def init(state) do
        case Application.get_env(:nautilus, :new_network) do
            false ->
                remote_gateways = Application.get_env(:nautilus, :remote_gateways)
                Enum.each(remote_gateways, fn gateway -> connect_to_gateway(elem(gateway, 0), elem(gateway, 1)) end)
                {:ok, state}
            _ ->
                {:ok, state}
        end
    end


    def connect_to_gateway(ip, port) do
        #IO.inspect(ip)
        #IO.inspect(port)
        _pid = spawn(@cluster_client, :start_link, [%{:ip => ip, :port => port, :discovery => true}])
        {:ok, :connected}
    end

end
