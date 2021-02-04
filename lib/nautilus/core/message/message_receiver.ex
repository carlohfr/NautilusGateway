defmodule Nautilus.Core.Message.MessageReceiver do

    require Logger
    alias Nautilus.Core.Message.MessageHandler

    def receive_this_message(pid, message) do
        Logger.info("MessageReceiver: #{message}") #just for test, remove in final version
        _pid = spawn(MessageHandler, :handle_this_message, [pid, message])
    end

end
