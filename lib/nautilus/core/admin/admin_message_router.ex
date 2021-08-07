defmodule Nautilus.Core.Admin.AdminMessageRouter do

    @moduledoc """
    This module is resposible routing admin and control messages
    """

    @split_content Application.get_env(:nautilus, :SplitContent)
    @command_router Application.get_env(:nautilus, :CommandRouter)
    @response_router Application.get_env(:nautilus, :ResponseRouter)


    def route_message(pid, message = %{"type" => "response"}) do
        {_, content} = @split_content.split_content(message["content"])
        @response_router.route_response(pid, message, content)
    end


    def route_message(pid, message = %{"type" => "command"}) do
        {_, content} = @split_content.split_content(message["content"])
        @command_router.route_command(pid, message, content)
    end


    def route_message(_pid, _) do
        {:error, :indefined_type}
    end

end
