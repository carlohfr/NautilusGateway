defmodule Nautilus.Core.Validators.MessageValidator.MessageValidator do

    @message_header_validator Application.get_env(:nautilus, :MessageHeaderValidator)
    @message_body_validator Application.get_env(:nautilus, :MessageBodyValidator)


    def validate_message(header, body) do
        case @message_header_validator.validate_header(header) do
            {:valid, header} ->
                case @message_body_validator.validate_body(header, body) do
                    {:valid, body} ->
                        {:valid, header, body}
                    _ ->
                        {:invalid, :body_fail}
                end
            _ ->
                {:invalid, :header_fail}
        end
    end

end
