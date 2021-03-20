defmodule Nautilus.Core.Actions.SendToClient do

    @moduledoc """
    This module is an action module for send message to a client
    """

    @behaviour Application.get_env(:nautilus, :MessageActionPort)
    @key_value_adapter Application.get_env(:nautilus, :KeyValueBucketInterface)
    @tcp_sender Application.get_env(:nautilus, :TCPSender)
    @message_maker Application.get_env(:nautilus, :MessageMaker)


    @doc """
    This function will try to send message to a client.
    """
    def execute(pid, message) do
        case @key_value_adapter.get(message["from"]) do
            {:ok, client_info} ->
                case client_info[:pid] == pid do
                    true ->
                        case @key_value_adapter.get(message["to"]) do
                            {:ok, client_info} ->
                                {_, message} = @message_maker.make_client_message(message)
                                @tcp_sender.send_message(client_info[:pid], message)
                            _ ->
                                {:error, :invaliddest}
                        end
                    _ ->
                        {:error, :invalidpid}
                end
            _ ->
                {:error, :invalidclient}
        end
    end

end
