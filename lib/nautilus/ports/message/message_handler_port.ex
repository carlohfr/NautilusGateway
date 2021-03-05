defmodule Nautilus.Ports.Message.MessageHandler do
    @callback handle_message(pid :: pid, message :: map()) :: any
end
