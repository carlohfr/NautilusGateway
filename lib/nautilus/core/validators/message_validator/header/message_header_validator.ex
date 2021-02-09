defmodule Nautilus.Core.Validators.MessageValidator.Header.MessageHeaderValidator do

    @message_header_syntax_validator Application.get_env(:nautilus, :MessageHeaderSyntaxValidator)

    def validate_header(header) do
        if Map.has_key?(header, "version") do
            version = header["version"]

            case get_header_fields(version) do
                {:ok, fields} ->
                    case @message_header_syntax_validator.validate_header(fields, header) do
                        :valid ->
                            {:valid, header}
                        _ ->
                            {:invalid, header}
                    end
                _ ->
                    {:invalid, header}
            end
        else
            {:invalid, header}
        end
    end


    def get_header_fields(version) do
        case version do
            "1.0" ->
                fields = ["version", "to", "from", "action", "type", "size"]
                {:ok, fields}
            _ ->
                {:error, :wrong_version}
        end
    end

end
