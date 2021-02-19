defmodule Nautilus.Core.Actions.SayHi do

    @behaviour Application.get_env(:nautilus, :MessageActionPort)

    def execute(header, _body) do
        from = header["from"]
        IO.puts("#{from} say hi")
    end

end
