defmodule Nautilus.Adapters.Network.Message.MessagePreparator do

    @moduledoc """
    This module is responsible for transforming message received to a map() and send to core
    """

    @split_content Application.get_env(:nautilus, :SplitContent)
    @message_handler Application.get_env(:nautilus, :MessageHandler)


    @doc """
    This function will control all steps of message preparation
    """
    def prepare_message(pid, message) do
        with {header_string, body} <- split_message(message), {:ok, header} <- @split_content.split_content(header_string) do
            message = Map.put(header, "content", body)
            @message_handler.handle_message(pid, message)
        else
            _ ->
                {:error, :invalid}
        end
    end


    # This function will split the message in two parts (header and body)
    def split_message(message) do
        case :binary.match(message, ["\r\n\r\n"]) do
            {start, length} ->
                header = :binary.part(message, 0, start)
                body = :binary.part(message, start + length, byte_size(message) - (start + length))
                {header, body}
            :nomatch ->
                :error
        end
    end

end
