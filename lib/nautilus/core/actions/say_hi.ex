defmodule Nautilus.Core.Actions.SayHi do

    @behaviour Application.get_env(:nautilus, :MessageActionPort)

    def execute(pid, message) do
        from = message["from"]
        IO.inspect(pid)
        IO.puts("#{from} say hi")
    end

end
