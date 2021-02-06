defmodule Nautilus.Ports.MessageReceiver do

    @callback receive_message(message :: any) :: any

end
