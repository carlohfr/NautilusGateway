defmodule Nautilus.Core.Actions.SendToGateway do

    @moduledoc """
    This module is an action module for send message to a gateway
    """

    @behaviour Application.get_env(:nautilus, :MessageActionPort)
    #@tcp_sender Application.get_env(:nautilus, :TCPSender)
    #@message_maker Application.get_env(:nautilus, :MessageMaker)
    @get_hostname Application.get_env(:nautilus, :GetHostname)
    @client_validator Application.get_env(:nautilus, :ClientValidator)
    @cluster_credentials Application.get_env(:nautilus, :ClusterCredentials)


    @doc """
    This function will receive a message from client, if the message is not for this gateway, will send to correct destination.
    """
    def execute(pid, message) do
        with {:ok, _} <- @client_validator.validate_client(message["from"], pid),
        {:ok, credentials} <- split_network_credentials(message["content"]),
        {:ok, :valid} <- @cluster_credentials.check_network_credentials(credentials["network-name"], credentials["network-password"], credentials["gateway-password"]) do

            {_, this_gateway} = @get_hostname.get_hostname()

            case this_gateway == message["to"] do
                true ->
                    # mensagem para esse gateway
                    IO.puts("Esse gateway")
                _ ->
                    # mensagem para um gateway remoto
                    IO.puts("Gateway remoto")
            end
        else
            _ ->
                {:error, :actionfail}
        end

        {_, network_name, network_password, gateway_password} = @cluster_credentials.get_network_credentials()
        content = "network-name: #{network_name}\r\nnetwork-password: #{network_password}\r\ngateway-password: #{gateway_password}"
        message = "version: 1.0\r\nto: 127.0.0.1:20000\r\nfrom: 127.0.0.1:10000\r\naction: test-action\r\ntype: request\r\nbody-size: #{byte_size(content)}\r\n\r\n#{content}"
        #IO.inspect(message)
        GenServer.cast(pid, {:send_message, message})
    end


    defp split_network_credentials(credentials) do
        case String.contains?(credentials, ["\r\n", ": "]) do
            true ->
                filtered_credentials = credentials
                |> String.split(["\r\n", ": "])
                |> Enum.chunk_every(2)
                |> Enum.map(fn [a, b] -> {a, b} end)
                |> Map.new

                {:ok, filtered_credentials}
            _ ->
                {:error, :no_fields}
        end
    end

end
