defmodule Nautilus.Core.Message.MessageHandler do

    def handle_message(message) do
        new_message = "MessageHandler: #{message}"
        IO.puts(new_message)
    end

end
