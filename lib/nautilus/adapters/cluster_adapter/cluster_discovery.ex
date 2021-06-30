defmodule Nautilus.Adapters.Cluster.ClusterDiscovery do

    @moduledoc """
    This module is resposible for send discovery message
    """

    @behaviour Application.get_env(:nautilus, :ClusterDiscoveryPort)
    @get_hostname Application.get_env(:nautilus, :GetHostname)
    @cluster_credentials Application.get_env(:nautilus, :ClusterCredentials)


    @doc """
    This function will send a discovery message to remote gateway
    """
    def send_discovery_message(pid, remote_gateway_ip) do
        {_, this_gateway} = @get_hostname.get_hostname()
        {_, network_name, network_password, gateway_password} = @cluster_credentials.get_network_credentials()

        content = "network-name: #{network_name}\r\nnetwork-password: #{network_password}\r\ngateway-password: #{gateway_password}\r\ncommand: get-gateway-list"
        message = "version: 1.0\r\nto: #{remote_gateway_ip}\r\nfrom: #{this_gateway}\r\naction: send-to-gateway\r\ntype: command\r\nbody-size: #{byte_size(content)}\r\n\r\n#{content}"
        GenServer.cast(pid, {:send_message, message})
    end

end
