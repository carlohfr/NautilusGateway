defmodule Nautilus.Ports.Utils.GetHostname do

    @moduledoc """
    This module establish a behavior for get hostname
    """

    @doc """
    This function will return the hostname
    """
    @callback get_hostname() :: tuple()

end
