defmodule Nautilus.Core.Admin.Commands.CMDGetClientList do

    @moduledoc """
    This module is responsible for process get client list command
    """

    @behaviour Application.get_env(:nautilus, :CMDPort)
    @get_hostname Application.get_env(:nautilus, :GetHostname)
    @cluster_credentials Application.get_env(:nautilus, :ClusterCredentials)
    @key_value_adapter Application.get_env(:nautilus, :KeyValueBucketInterface)


    def execute_command(pid, message) do
        {_, this_gateway} = @get_hostname.get_hostname()
        {_, network_name, network_password, gateway_password} = @cluster_credentials.get_network_credentials()
        {_, client_list} = @key_value_adapter.get_client_list()

        client_list = Enum.join(client_list, ", ")
        client_list = "[#{client_list}]"

        to = message["from"]
        content = "network-name: #{network_name}\r\nnetwork-password: #{network_password}\r\ngateway-password: #{gateway_password}\r\nmessage-notify: client-list\r\nclient-list: #{client_list}"
        response = "version: 1.0\r\nto: #{to}\r\nfrom: #{this_gateway}\r\naction: send-to-gateway\r\ntype: response\r\nbody-size: #{byte_size(content)}\r\n\r\n#{content}"
        GenServer.cast(pid, {:send_message, response})
    end

end
