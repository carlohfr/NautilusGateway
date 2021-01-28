defmodule Nautilus.Handlers.MessageHandler do

    require Logger

    def process_message(pid, message) do
        #just for test, remove in final version
        new_message = "MessageHandler: #{message}"
        Logger.info(new_message) #just for test, remove in final version

        GenServer.cast(pid, {:send_message, new_message})
    end

end
