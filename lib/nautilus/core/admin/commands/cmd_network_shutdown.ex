defmodule Nautilus.Core.Admin.Commands.CMDNetworkShutdown do

    @moduledoc """
    This module is responsible for process network shutdown command
    """
    require Logger

    @behaviour Application.get_env(:nautilus, :CMDPort)
    @get_hostname Application.get_env(:nautilus, :GetHostname)
    @cluster_credentials Application.get_env(:nautilus, :ClusterCredentials)
    @key_value_adapter Application.get_env(:nautilus, :KeyValueBucketInterface)


    def execute_command(_pid, _message) do
        {_, this_gateway} = @get_hostname.get_hostname()
        {_, network_name, network_password, gateway_password} = @cluster_credentials.get_network_credentials()
        {_, gateway_list} = @key_value_adapter.get_gateway_list()

        Enum.each(gateway_list, fn gateway ->

            {_, gateway_info} = @key_value_adapter.get(gateway)

            content = "network-name: #{network_name}\r\nnetwork-password: #{network_password}\r\ngateway-password: #{gateway_password}\r\ncommand: gateway-shutdown"
            response = "version: 1.0\r\nto: #{gateway}\r\nfrom: #{this_gateway}\r\naction: send-to-gateway\r\ntype: command\r\nbody-size: #{byte_size(content)}\r\n\r\n#{content}"
            GenServer.cast(gateway_info[:pid], {:send_message, response})
        end)

        Logger.info("Network stopped") #just for test, remove in final version
        System.stop(0)
    end

end
