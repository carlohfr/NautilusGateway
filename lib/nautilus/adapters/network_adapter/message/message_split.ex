defmodule Nautilus.Network.Message.MessageSplit do

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


    def split_header_fields(header_string) do
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
