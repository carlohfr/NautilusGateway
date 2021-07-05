defmodule Nautilus.Core.Actions.SendToClient do

    @moduledoc """
    This module is an action module for send message to a client
    """

    @behaviour Application.get_env(:nautilus, :MessageActionPort)
    @tcp_sender Application.get_env(:nautilus, :TCPSender)
    @get_hostname Application.get_env(:nautilus, :GetHostname)
    @message_maker Application.get_env(:nautilus, :MessageMaker)
    @client_validator Application.get_env(:nautilus, :ClientValidator)
    @key_value_adapter Application.get_env(:nautilus, :KeyValueBucketInterface)


    @doc """
    This function will try to send message to a client.
    """
    def execute(pid, message) do
        with {:ok, _} <- @client_validator.validate_client(message["from"], pid) do
            with {:ok, client_info} <- @key_value_adapter.get(message["to"]),
                {:ok, _} <- @client_validator.validate_client(message["to"], client_info[:pid]) do
                {_, message} = @message_maker.make_message(message)
                @tcp_sender.send_message(client_info[:pid], message)
            else
                _ ->
                    [_client_id, gateway_address] = message["to"] |> String.split("@")
                    {_, this_gateway} = @get_hostname.get_hostname()

                    with true <- gateway_address != this_gateway,
                        {:ok, gateway_info} <- @key_value_adapter.get(gateway_address),
                        {:ok, _} <- @client_validator.validate_client(gateway_address, gateway_info[:pid]) do
                        {_, forward_message} = @message_maker.make_forward_to_client_message(message, this_gateway, gateway_address)
                        @tcp_sender.send_message(gateway_info[:pid], forward_message)
                    else
                        _ ->
                            {:error, :actionfail}
                    end
            end
        else
            _ ->
                {:error, :invalidclient}
        end
    end

end
