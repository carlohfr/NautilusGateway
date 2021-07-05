defmodule Nautilus.Core.Actions.ForwardToClient do

    @moduledoc """
    This module is an action module for forward message to a client
    """

    @behaviour Application.get_env(:nautilus, :MessageActionPort)
    @message_preparator Application.get_env(:nautilus, :MessagePreparator)
    @tcp_sender Application.get_env(:nautilus, :TCPSender)
    @get_hostname Application.get_env(:nautilus, :GetHostname)
    @message_maker Application.get_env(:nautilus, :MessageMaker)
    @client_validator Application.get_env(:nautilus, :ClientValidator)
    @key_value_adapter Application.get_env(:nautilus, :KeyValueBucketInterface)


    @doc """
    This function will try to forward message to a client
    """
    def execute(pid, message) do
        {_, this_gateway} = @get_hostname.get_hostname()

        with true <- message["to"] == this_gateway,
            {:ok, _} <- @client_validator.validate_client(message["from"], pid) do

                with {header_string, body} <- @message_preparator.split_message(message["content"]), {:ok, header} <- @message_preparator.split_header_fields(header_string) do
                    message_to_client = Map.put(header, "content", body)

                    with {:ok, client_info} <- @key_value_adapter.get(message_to_client["to"]),
                        {:ok, _} <- @client_validator.validate_client(message_to_client["to"], client_info[:pid]) do
                        {_, message_to_send} = @message_maker.make_message(message_to_client)
                        @tcp_sender.send_message(client_info[:pid], message_to_send)
                    else
                        _ ->
                            {:error, :invalidclient}
                    end
                else
                    _ ->
                        {:error, :invalid}
                end
        end
    end
end
