defmodule Nautilus.Adapters.Cluster.ClusterDiscovery do

    @moduledoc """
    This module is resposible for send discovery message
    """

    @behaviour Application.get_env(:nautilus, :ClusterDiscoveryPort)
    @cluster_credentials Application.get_env(:nautilus, :ClusterCredentials)


    @doc """
    This function will send a discovery message to remote gateway
    """
    def send_discovery_message(pid) do
        {_, network_name, network_password, gateway_password} = @cluster_credentials.get_network_credentials()
        content = "network-name: #{network_name}\r\nnetwork-password: #{network_password}\r\ngateway-password: #{gateway_password}"
        message = "version: 1.0\r\nto: 127.0.0.1:20000\r\nfrom: 127.0.0.1:10000\r\naction: test-action\r\ntype: request\r\nbody-size: #{byte_size(content)}\r\n\r\n#{content}"
        GenServer.cast(pid, {:send_message, message})
    end

end
