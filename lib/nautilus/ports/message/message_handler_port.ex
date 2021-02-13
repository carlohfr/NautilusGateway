defmodule Nautilus.Ports.Message.MessagePreparator do
    @callback prepare_message(message :: any) :: any
end
