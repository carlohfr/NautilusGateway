defmodule Nautilus.Ports.Message.MessageReceiver do
    @callback receive_message(header :: any, body :: any) :: any
end
