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
    @admin_message_router Application.get_env(:nautilus, :AdminMessageRouter)


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
                    # Message to this gateway
                    @admin_message_router.route_message(pid, message)
                _ ->
                    # Message to remote gateway
                    IO.puts("Gateway remoto")
            end
        else
            _ ->
                {:error, :actionfail}
        end
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
