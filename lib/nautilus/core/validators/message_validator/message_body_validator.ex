defmodule Nautilus.Core.Validators.MessageValidator.MessageBodyValidor do

    def validate_body(header, body) do
        size_string = header["size"]
        size_int = String.to_integer(size_string)


        if(size_int == byte_size(body)) do
            {:valid, body}
        else
            {:invalid, body}
        end
    end

end