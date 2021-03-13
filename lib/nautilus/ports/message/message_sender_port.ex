defmodule Nautilus.Ports.Message.MessageSender do

    @moduledoc """
    This module establish a behavior for message sender
    """

    @doc """
    This function will send a message to a client (pid is necessary)
    """
    @callback send_message(pid :: pid, message :: map()) :: any

end
