defmodule Nautilus.Network.MessagePreparator do

    @message_handler Application.get_env(:nautilus, :MessageHandler)


    def prepare_message(pid, message) do
        case split_message(message) do
            {header_string, body} ->
                case split_header_fields(header_string) do
                    {:ok, header} ->
                        @message_handler.handle_message(pid, header, body)
                    _ ->
                        :invalid
                end
            _ ->
                :invalid
        end
    end


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
