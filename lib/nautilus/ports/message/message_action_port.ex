defmodule Nautilus.Ports.Message.MessageAction do
    @callback execute(pid :: pid, header :: any, body :: any) :: any
end
