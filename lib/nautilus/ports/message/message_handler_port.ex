defmodule Nautilus.Ports.Message.MessageHandler do

    @moduledoc """
    This module establish a behavior for message handler
    """

    @doc """
    This function will handle a message
    """
    @callback handle_message(pid :: pid, message :: map()) :: any

end
