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
        connect_to_gateway({127, 0, 0, 1}, 20000)
        {:ok, state}
    end


    def connect_to_gateway(ip, port) do
        _pid = spawn(@cluster_client, :start_link, [%{:ip => ip, :port => port}])
        {:ok, :connected}
    end

end
