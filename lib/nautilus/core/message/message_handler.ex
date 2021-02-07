defmodule Nautilus.Core.Message.MessageHandler do

    @message_validator Application.get_env(:nautilus, :MessageValidator)

    def handle_message(message) do

        case @message_validator.validate_message(message) do
            {:valid, header, body} ->
                {header, body}
            _ ->
                :invalid
        end

        #get action


        #do action
    end

end
