defmodule Nautilus.Core.Validators.MessageValidator.MessageValidator do

    @syntax_validator Application.get_env(:nautilus, :MessageSyntaxValidator)
    @content_size_validator Application.get_env(:nautilus, :MessageContentSizeValidator)


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
