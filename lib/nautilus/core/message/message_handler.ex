defmodule Nautilus.Core.Message.MessageHandler do

    @message_validator Application.get_env(:nautilus, :MessageValidator)

    def handle_message(message) do

        header = elem(message, 0)
        body = elem(message, 1)

        case @message_validator.validate_message(header, body) do
            {:valid, header, body} ->
                IO.puts("Valid message")
                IO.inspect({header, body})
            _ ->
                IO.puts("Invalid message")
                :invalid
        end

        #get action


        #do action
    end

end
