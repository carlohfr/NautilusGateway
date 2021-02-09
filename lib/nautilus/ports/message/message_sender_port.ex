defmodule Nautilus.Ports.Message.MessageSender do
    @callback send_message(pid :: pid, message :: any) :: any
end
