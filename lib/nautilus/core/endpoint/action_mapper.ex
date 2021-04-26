defmodule Nautilus.Core.Endpoint.ActionMapper do

    @moduledoc """
    This module is responsible for mapping an action to a module
    """

    @doc """
    This function receive a action and return module name
    """
    def get_action("register-client"), do: {:ok, :RegisterClient}
    def get_action("send-to-client"), do: {:ok, :SendToClient}
    def get_action("test-action"), do: {:ok, :TestAction}
    def get_action(_), do: {:error, :no_action_found}

end
