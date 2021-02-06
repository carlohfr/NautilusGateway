defmodule Nautilus.TCPMessageListener.TCPSender do

    def send_message(pid, message) do
        GenServer.cast(pid, {:send_message, message})
    end

end
