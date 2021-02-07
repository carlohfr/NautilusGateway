defmodule Nautilus.Core.Validators.MessageValidator do

    @message_header_validator Application.get_env(:nautilus, :MessageHeaderValidator)
    @message_body_validator Application.get_env(:nautilus, :MessageBodyValidator)


    def validate_message(message) do
        case split_message(message) do
            {header_string, body} ->
                case @message_header_validator.validate_header(header_string) do
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
            _ ->
                {:invalid, :split_fail}
        end
    end


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
