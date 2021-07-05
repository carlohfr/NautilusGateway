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


    @doc """
    This function will make a send to gateway message
    """
    def make_send_to_gateway_message(type, from, to, content) do
        message = "version: 1.0\r\nto: #{to}\r\nfrom: #{from}\r\naction: send-to-gateway\r\ntype: #{type}\r\nbody-size: #{byte_size(content)}\r\n\r\n#{content}"
        {:ok, message}
    end


    @doc """
    This function will make a forward to client message
    """
    def make_forward_to_client_message(message, from, to) do
        {_, content} = make_message(message)
        IO.inspect(content)
        forward_message = "version: 1.0\r\nto: #{to}\r\nfrom: #{from}\r\naction: forward-to-client\r\ntype: message\r\nbody-size: #{byte_size(content)}\r\n\r\n#{content}"
        IO.inspect(forward_message)
        {:ok, forward_message}
    end
end
