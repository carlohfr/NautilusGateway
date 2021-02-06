defmodule Nautilus.Core.Message.MessageReceiver do

    require Logger

    @behaviour Application.get_env(:nautilus, :MessageReceiverPort)
    @message_handler Application.get_env(:nautilus, :MessageHandler)

    def receive_message(message) do

        Logger.info("MessageReceiver: #{message}") #just for test, remove in final version

        _pid = spawn(@message_handler, :handle_message, [message])
    end

end
