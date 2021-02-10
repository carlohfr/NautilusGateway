defmodule Nautilus.Ports.Message.MessageHandler do
    @callback handle_message(header :: any, body :: any) :: any
end
