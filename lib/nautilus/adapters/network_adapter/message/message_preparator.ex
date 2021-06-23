defmodule Nautilus.Adapters.Network.Message.MessagePreparator do

    @moduledoc """
    This module is responsible for transforming message received to a map() and send to core
    """

    @message_handler Application.get_env(:nautilus, :MessageHandler)


    @doc """
    This function will control all steps of message preparation
    """
    def prepare_message(pid, message) do
        with {header_string, body} <- split_message(message), {:ok, header} <- split_header_fields(header_string) do
            message = Map.put(header, "content", body)
            @message_handler.handle_message(pid, message)
        else
            _ ->
                {:error, :invalid}
        end
    end


    # This function will split the message in two parts (header and body)
    defp split_message(message) do
        case :binary.match(message, ["\r\n\r\n"]) do
            {start, length} ->
                header = :binary.part(message, 0, start)
                body = :binary.part(message, start + length, byte_size(message) - (start + length))
                {header, body}
            :nomatch ->
                :error
        end
    end


    # This function will split the header fields of a message
    defp split_header_fields(header_string) do
        case String.contains?(header_string, ["\r\n", ": "]) do
            true ->
                header = header_string
                |> String.split(["\r\n", ": "])
                |> Enum.chunk_every(2)
                |> Enum.map(fn [a, b] -> {a, b} end)
                |> Map.new

                {:ok, header}
            _ ->
                {:error, :no_fields}
        end
    end

end
