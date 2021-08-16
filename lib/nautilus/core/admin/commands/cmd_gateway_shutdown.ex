defmodule Nautilus.Core.Admin.Commands.CMDGatewayShutdown do

    @moduledoc """
    This module is responsible for process gateway shutdown command
    """
    require Logger

    @behaviour Application.get_env(:nautilus, :CMDPort)


    def execute_command(_pid, _message) do
        Logger.info("Gateway stopped") #just for test, remove in final version
        System.stop(0)
    end

end
