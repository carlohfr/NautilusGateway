defmodule Nautilus.Adapters.Utils.SplitContent do

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

end
