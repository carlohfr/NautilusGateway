defmodule Nautilus.Ports.Message.MessageAction do
    @callback execute(header :: any, body :: any) :: any
end
