defmodule Nautilus.Adapters.Network.TCP.TCPSender do

    @moduledoc """
    This module is responsible for send a tcp message to client
    """

    @behaviour Application.get_env(:nautilus, :MessageSenderPort)


    @doc """
    This function will send a message to a client (pid is necessary)
    """
    def send_message(pid, message) do
        GenServer.cast(pid, {:send_message, message})
    end

end
