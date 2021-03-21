defmodule Nautilus.Core.Validators.MessageValidator.MessageValidator do

    @moduledoc """
    This module is responsible for validate a message
    """

    @syntax_validator Application.get_env(:nautilus, :MessageSyntaxValidator)
    @content_size_validator Application.get_env(:nautilus, :MessageContentSizeValidator)


    @doc """
    This function will organize all steps of message validation process
    """
    def validate_message(message) do
        with {:valid, _} <- @syntax_validator.validate_message_syntax(message),
        {:valid, _} <- @content_size_validator.validate_content_size(message) do
            {:valid, message}
        else
            _ ->
                {:invalid, message}
        end
    end

end
