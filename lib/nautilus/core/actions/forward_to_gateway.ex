defmodule Nautilus.Core.Actions.ForwardToGateway do

    @moduledoc """
    This module is an action module for forward message to a gateway
    """

    @behaviour Application.get_env(:nautilus, :MessageActionPort)
    @split Application.get_env(:nautilus, :Split)
    #@tcp_sender Application.get_env(:nautilus, :TCPSender)
    @get_hostname Application.get_env(:nautilus, :GetHostname)
    #@message_maker Application.get_env(:nautilus, :MessageMaker)
    @client_validator Application.get_env(:nautilus, :ClientValidator)
    ##@key_value_adapter Application.get_env(:nautilus, :KeyValueBucketInterface)


    @doc """
    This function will try to forward message to a gateway
    """
    def execute(pid, message) do
        {_, this_gateway} = @get_hostname.get_hostname()

        with true <- message["to"] == this_gateway,
            {:ok, _} <- @client_validator.validate_client(message["from"], pid) do

                with {header_string, body} <- @split.split_message(message["content"]), {:ok, header} <- @split.split_content(header_string) do
                    message_received = Map.put(header, "content", body)
                    IO.inspect(message_received)

                    # This action is not working at this moment because has no way to return a response to client not connected
                else
                    _ ->
                        {:error, :invalid}
                end
        end
    end
end
