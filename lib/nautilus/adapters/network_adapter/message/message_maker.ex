defmodule Nautilus.Adapters.Network.Message.MessageMaker do

    @moduledoc """
    This module is responsible for make client return messages
    """

    @behaviour Application.get_env(:nautilus, :MessageMakerPort)


    @doc """
    This function will make a message
    """
    def make_message(message) do
        message = "version: " <> message["version"] <> "\r\nto: " <> message["to"] <> "\r\nfrom: " <> message["from"] <> "\r\naction: " <> message["action"] <> "\r\ntype: " <> message["type"] <> "\r\nbody-size: " <> message["body-size"] <> "\r\n\r\n" <>  message["content"]
        {:ok, message}
    end


    @doc """
    This function will make a notify message
    """
    def make_send_to_client_message(from, to, content) do
        message = "version: 1.0\r\nto: #{to}\r\nfrom: #{from}\r\naction: send-to-client\r\ntype: text\r\nbody-size: #{byte_size(content)}\r\n\r\n#{content}"
        {:ok, message}
    end

end
