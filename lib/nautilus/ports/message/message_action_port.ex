defmodule Nautilus.Ports.Message.MessageAction do

    @moduledoc """
    This module establish a behavior for message action
    """

    @doc """
    This function will implements message action
    """
    @callback execute(pid :: pid, message :: map()) :: any

end
