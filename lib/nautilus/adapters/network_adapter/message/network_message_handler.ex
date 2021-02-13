defmodule Nautilus.Network.Message.NetworkMessageHandler do

    @message_preparator Application.get_env(:nautilus, :MessagePreparator)


    def handle_message(message) do
        @message_preparator.prepare_message(message)
    end

end
