defmodule Nautilus.Core.Validators.MessageValidator.MessageContentSizeValidator do

    @moduledoc """
    This module is responsible for validate the content size
    """

    @doc """
    This function receive a message and validate the content size
    """
    def validate_content_size(message) do
        case Map.has_key?(message, "body-size") do
            :true ->
                size_int = message["body-size"] |> String.to_integer()

                case size_int == byte_size(message["content"]) do
                    :true ->
                        {:valid, message}
                    _ ->
                        {:invalid, message}
                end
            _ ->
                {:invalid, message}
        end
    end

end
