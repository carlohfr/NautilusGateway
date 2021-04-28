defmodule Nautilus.Core.Actions.RegisterGateway do

    @moduledoc """
    This module is an action module for register a gateway
    """

    @behaviour Application.get_env(:nautilus, :MessageActionPort)
    #@tcp_sender Application.get_env(:nautilus, :TCPSender)
    #@get_hostname Application.get_env(:nautilus, :GetHostname)
    #@message_maker Application.get_env(:nautilus, :MessageMaker)
    #@key_value_adapter Application.get_env(:nautilus, :KeyValueBucketInterface)


    @doc """
    This function will try to register the gateway.
    """
    def execute(_pid, message) do
        IO.inspect(message)
        {:ok, :test}
    end

end
