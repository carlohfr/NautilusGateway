defmodule Nautilus.Core.Validators.MessageValidator.MessageHeaderValidator do

    @message_header_protocol Application.get_env(:nautilus, :MessageHeaderProtocol)
    @message_header_syntax_validator Application.get_env(:nautilus, :MessageHeaderSyntaxValidator)


    def validate_header(header_string) do
        header = split_header_fields(header_string)

        if Map.has_key?(header, "version") do
            version = header["version"]

            case @message_header_protocol.get_header_fields(version) do
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


    def split_header_fields(header_string) do
        header_string
        |> String.split(["\r\n", ": "])
        |> Enum.chunk_every(2)
        |> Enum.map(fn [a, b] -> {a, b} end)
        |> Map.new
    end

end
