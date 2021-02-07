defmodule Nautilus.Core.Message.MessageReceiver do

    @behaviour Application.get_env(:nautilus, :MessageReceiverPort)
    @message_handler Application.get_env(:nautilus, :MessageHandler)


    def receive_message(message) do
        _pid = spawn(@message_handler, :handle_message, [message])
    end

end
