defmodule Nautilus.Ports.Message.MessageHandler do
    @callback handle_message(pid :: pid, header :: any, body :: any) :: any
end
