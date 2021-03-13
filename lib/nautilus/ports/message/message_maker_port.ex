defmodule Nautilus.Ports.Message.MessageMaker do

    @moduledoc """
    This module establish a behavior for message maker
    """

    @doc """
    This function will make a notify message
    """
    @callback make_notify_message(version :: String.t , from :: String.t , to :: String.t, content :: String.t) :: any

end
