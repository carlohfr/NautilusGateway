defmodule Nautilus.Ports.Message.MessageAction do
    @callback execute(pid :: pid, message :: map()) :: any
end
