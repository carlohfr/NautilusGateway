defmodule Nautilus.Core.Message.MessagePreparator do

    @behaviour Application.get_env(:nautilus, :MessagePreparatorPort)
    @message_validator Application.get_env(:nautilus, :MessageValidator)
    @action_mapper Application.get_env(:nautilus, :ActionMapper)


    # needs refactor
    def prepare_message(message) do
        case split_message(message) do
            {header_string, body} ->
                case split_header_fields(header_string) do
                    {:ok, header} ->
                        case @message_validator.validate_message(header, body) do
                            {:valid, header, body} ->
                                case @action_mapper.get_action(header["action"]) do
                                    {:ok, module} ->
                                        action = Application.get_env(:nautilus, module)
                                        action.execute(header, body)
                                    _ ->
                                        :invalid
                                end
                            _ ->
                                :invalid
                        end
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
