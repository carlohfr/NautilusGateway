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
        case @syntax_validator.validate_message_syntax(message) do
            {:valid, _} ->
                case @content_size_validator.validate_content_size(message) do
                    {:valid, _} ->
                        {:valid, message}
                    _ ->
                        {:invalid, :content_size_fail}
                end
            _ ->
                {:invalid, :syntax_fail}
        end
    end

end
