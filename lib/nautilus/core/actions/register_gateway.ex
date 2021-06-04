defmodule Nautilus.Core.Actions.RegisterGateway do

    @moduledoc """
    This module is an action module for register a gateway
    """

    @behaviour Application.get_env(:nautilus, :MessageActionPort)
    @tcp_sender Application.get_env(:nautilus, :TCPSender)
    @message_maker Application.get_env(:nautilus, :MessageMaker)
    @cluster_credentials Application.get_env(:nautilus, :ClusterCredentials)
    @key_value_adapter Application.get_env(:nautilus, :KeyValueBucketInterface)


    @doc """
    This function will try to register the gateway.
    """
    def execute(pid, message) do
        remote_gateway_address = String.split(message["from"], ":")
        remote_gateway_ip = Enum.at(remote_gateway_address, 0)
        remote_gateway_port = String.to_integer(Enum.at(remote_gateway_address, 1))

        gateway_info =  %{:pid => pid, :ip => remote_gateway_ip, :port => remote_gateway_port, :type => :gateway}

        with true <- Process.alive?(pid), {:ok, credentials} <- split_network_credentials(message["content"]),
        {:ok, :valid} <- @cluster_credentials.check_network_credentials(credentials["network-name"], credentials["network-password"], credentials["gateway-password"]),
        :ok <- @key_value_adapter.set({message["from"], gateway_info}) do
            {_, network_name, network_password, gateway_password} = @cluster_credentials.get_network_credentials()
            content = "network-name: #{network_name}\r\nnetwork-password: #{network_password}\r\ngateway-password: #{gateway_password}\r\nmessage-notify: gateway-registered"
            {_, message} = @message_maker.make_send_to_gateway_message("response", message["to"], message["from"], content)
            @tcp_sender.send_message(pid, message)
        else
            false ->
                {:error, :invalidpid}
            _ ->
                {_, message} = @message_maker.make_send_to_gateway_message("response", message["to"], message["from"], "message-notify: register-fail")
                @tcp_sender.send_message(pid, message)
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
