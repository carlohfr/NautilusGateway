defmodule Nautilus.Ports.Admin.CMDPort do

    @moduledoc """
    This module establish a behavior for commands
    """

    @doc """
    This function will execute the command
    """
    @callback execute_command(pid :: pid(), message :: any) :: any

end
