defmodule Nautilus.Core.Actions.SayHi do

    @behaviour Application.get_env(:nautilus, :MessageActionPort)

    def execute(pid, header, _body) do
        from = header["from"]
        IO.inspect(pid)
        IO.puts("#{from} say hi")
    end

end
