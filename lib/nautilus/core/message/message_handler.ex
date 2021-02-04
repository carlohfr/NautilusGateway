defmodule Nautilus.Core.Message.MessageHandler do

    require Logger

    def handle_this_message(pid, message) do
        new_message = "MessageHandler: #{message}"
        GenServer.cast(pid, {:send_message, new_message}) #just for test, remove in final version
    end

end
