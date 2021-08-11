defmodule Nautilus.Core.Admin.CommandRouter do

    @moduledoc """
    This module is responsible for routing commands
    """

    @cmd_kick Application.get_env(:nautilus, :CMDKick)
    @cmd_get_gateway_list Application.get_env(:nautilus, :CMDGetGatewayList)


    def route_command(pid, message, %{"command" => "get-gateway-list"}) do
        @cmd_get_gateway_list.execute_command(pid, message)
    end


    def route_command(pid, message, %{"command" => "kick"}) do
        @cmd_kick.execute_command(pid, message)
    end


    def route_command(_pid, _message, _) do
        {:error, :indefined_command}
    end

end
