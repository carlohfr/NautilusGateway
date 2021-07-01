defmodule Nautilus.Adapters.Cluster.ClusterManager do

    @moduledoc """
    This module is responsible for managing all connections with remote gateways
    """

    use GenServer

    @get_hostname Application.get_env(:nautilus, :GetHostname)
    @cluster_client Application.get_env(:nautilus, :ClusterClient)
    @key_value_adapter Application.get_env(:nautilus, :KeyValueBucketInterface)


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


    def prepare_gateway_list(gateway_list) do
        {_, this_gateway} = @get_hostname.get_hostname()
        {_, known_gateways} = @key_value_adapter.get_all() |> filter_gateways()

        gateway_list
        |> String.replace("[", "")
        |> String.replace("]", "")
        |> String.split(", ")
        |> Enum.reject(fn gateway -> gateway == this_gateway or gateway in known_gateways end)
        |> Enum.each(fn gateway ->
            gateway_address = String.split(gateway, ":")
            {_, gateway_ip} = Enum.at(gateway_address, 0) |> String.to_charlist |> :inet.parse_address
            gateway_port = Enum.at(gateway_address, 1) |> String.to_integer()

            connect_to_gateway(gateway_ip, gateway_port)
        end)
    end


    def connect_to_gateway(ip, port) do
        _pid = spawn(@cluster_client, :start_link, [%{:ip => ip, :port => port, :discovery => true}])
        {:ok, :connected}
    end


    defp filter_gateways(client_list) do
        gateway_list = Enum.map(client_list, fn {key, value} ->
            case value[:type] == :gateway do
                :true ->
                    key
            end
        end)

        {:ok, gateway_list}
    end

end
