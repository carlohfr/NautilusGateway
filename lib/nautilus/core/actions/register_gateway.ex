defmodule Nautilus.Core.Actions.RegisterGateway do

    @moduledoc """
    This module is an action module for register a gateway
    """

    @behaviour Application.get_env(:nautilus, :MessageActionPort)
    @tcp_sender Application.get_env(:nautilus, :TCPSender)
    @message_maker Application.get_env(:nautilus, :MessageMaker)
    @key_value_adapter Application.get_env(:nautilus, :KeyValueBucketInterface)


    @doc """
    This function will try to register the gateway.
    """
    def execute(pid, message) do
        remote_gateway_address = String.split(message["from"], ":")
        remote_gateway_ip = Enum.at(remote_gateway_address, 0)
        remote_gateway_port = String.to_integer(Enum.at(remote_gateway_address, 1))

        gateway_info =  %{:pid => pid, :ip => remote_gateway_ip, :port => remote_gateway_port, :type => :gateway}

        with true <- Process.alive?(pid), :ok <- @key_value_adapter.set({message["from"], gateway_info}) do
            {_, message} = @message_maker.make_send_to_gateway_message(message["to"], message["from"], "OK")
            @tcp_sender.send_message(pid, message)
        else
            false ->
                {:error, :invalidpid}
            _ ->
                {_, message} = @message_maker.make_send_to_gateway_message(message["to"], message["from"], "ERROR")
                @tcp_sender.send_message(pid, message)
        end
    end

end
