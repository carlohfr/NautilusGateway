defmodule Nautilus.Network.Message.MessagePreparator do

    @message_split Application.get_env(:nautilus, :MessageSplit)
    @message_receiver Application.get_env(:nautilus, :MessageReceiver)

    def prepare_message(message) do
        case @message_split.split_message(message) do
            {header_string, body} ->
                case @message_split.split_header_fields(header_string) do
                    {:ok, header} ->
                        @message_receiver.receive_message(header, body)
                    _ ->
                        :invalid
                end
            _ ->
                :invalid
        end
    end

end
