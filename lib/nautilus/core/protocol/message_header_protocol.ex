defmodule Nautilus.Core.Protocol.MessageHeaderProtocol do

    def get_header_fields(version) do
        case version do
            "1.0" ->
                fields = Application.get_env(:nautilus, :MessageHeaderV1)
                {:ok, fields}
            _ ->
                {:error, :wrong_version}
        end
    end

end
