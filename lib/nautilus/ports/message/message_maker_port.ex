defmodule Nautilus.Ports.Message.MessageMaker do
    @callback make_notify_message(version :: String.t , from :: String.t , to :: String.t, content :: String.t) :: any
end
