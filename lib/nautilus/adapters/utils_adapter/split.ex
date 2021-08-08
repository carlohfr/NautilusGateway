defmodule Nautilus.Adapters.Utils.Split do

    @moduledoc """
    This module is responsible split content
    """

    @doc """
    This function will split the content fields
    """
    def split_content(content) do
        case String.contains?(content, ["\r\n", ": "]) do
            true ->
                filtered_content = content
                |> String.split(["\r\n", ": "])
                |> Enum.chunk_every(2)
                |> Enum.map(fn [a, b] -> {a, b} end)
                |> Map.new

                {:ok, filtered_content}
            _ ->
                {:error, :no_fields}
        end
    end


    @doc """
    This function will split the message in two parts (header and body)
    """
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
